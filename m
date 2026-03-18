Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5584210775F9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vID-0000fs-I7; Wed, 18 Mar 2026 14:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vIA-0000ef-LP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:06:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vI8-0002aY-60
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:06:50 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so426865ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773857206; x=1774462006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sxAcDQxzHUN0fmhiL3YHfq5erwu43dV6xeO09m4XFKQ=;
 b=WMAXipADynJVBtFssWk6+EMVHSDZMoET6Seia1S1xngk4PTNqbA1EldnSsJzJEMmrp
 zKSPGEuaocXtvhG+jHDu8FsvoydvsG/EqLeczlmiqjo4gbWg/tJUzZilelO2ftUQFdjU
 DhuNjy5aw0zmUCxq7QpKKpEBLnc119j7mBE7HwuXzeEEgI0EfisTQX4kY3uJOhawEBon
 h7dC72m28xfwEOyT/ZjIPAj39RkCe1pyuu41fycuws76rIZZGPdzGSYlIKTYnZ1CqLe/
 zqtBjwViNFVQdS5VY+9HofiT8TohK51s7ZIoCTunlX8x/LYoD+SiJNZV0WycbuQ++ilq
 juMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773857206; x=1774462006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxAcDQxzHUN0fmhiL3YHfq5erwu43dV6xeO09m4XFKQ=;
 b=dx71AruTYlmqMkDHoeNy3YUpAWh12vvil/XsolHZZfandwN7OQVngNBphuscIgzbrH
 0yeZNWnhv4CLuiFC98UXj86h5FxOu8GOPPMj9+lwh3GlV+daCqAH4jAIjD6H9+HoZACi
 vOCXGWC45XpBmZiSxFzYJFIqdiMIw854lbmCBDGRnZcNeGzvicxD1UzNL2QQi0V2N5wD
 1ZY8JvE3YxOSxHtdFGc5ASvvHpPeXEN11/N2qaiElp+PO/DsvHdbp5trtW+YHekYU+Ss
 tlIS/hB4hwHGIG9wLAanHeyW3RhBFgaP7KXDetthoSvef2Y0tpil7Ag/XvETumOpj9Ra
 +49A==
X-Gm-Message-State: AOJu0YztxT/nXmdeC1glAteLeEnfTxU/fqNedEDDs8BZ+ASParz/2s33
 qcIj8er39nX4Nq8KsNo0W43ZQu3ryRZ4PGPHuZGD8bAY9NhvmN57vBpHj4x+2r7sJbFkB4FK2Sl
 RpgjzZfc=
X-Gm-Gg: ATEYQzzDt46UnLonihXvu8QmFV1PODwdqNYknp97c7a9b1XQJYBXl/TxIZ1Buzf/AHv
 4+wTI9OXbfvwpo1zQgb6mKRt/plOz3MtGklhouZd1pTJj3t8TGxvUTkoZNucYHkwf2TvHCVBMN5
 yVbYEjlJUjNLx0pJrf2tKm73Zcx7trBl7lR6dG+wkMjp+mRG2RMLKrGiK11SJVWgKqd0elpdHF1
 gkxT0+3MEAKKjBkhDKoa03HCQD6nSgziI/NtVr33yQPtEV39vl/9J3ty0edwfGXCzWLnRJYrLFk
 /UQnPDf2n/q/ODFj9dThqknFWY/+jHehE2mx+M3/lSZgjgPXk1+++Dk8eqD2OzMHTumlGJwM/27
 I1GfmIusGG0tDtjIJGK6awipyuxRBJZHnqeYOH6X/S0AMCDfwOUHTRUfbyyPE30JU0IwOM96qiI
 cakNTpunBpAbSxYrlh5EWJVw63BeDAGs1Ne2qgZHgiSRjuG/AiYjXL6RdxSFcuHiMDZU/VodJNa
 nX6
X-Received: by 2002:a17:902:d507:b0:2b0:62dd:3a93 with SMTP id
 d9443c01a7336-2b06e3243b6mr44826015ad.7.1773857206284; 
 Wed, 18 Mar 2026 11:06:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e4314easm47354355ad.21.2026.03.18.11.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:06:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex@shazbot.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 0/2] iommufd: give hints to user about kernel support
Date: Wed, 18 Mar 2026 11:06:39 -0700
Message-ID: <20260318180641.1797902-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Using iommufd requires two different kernel config:
CONFIG_IOMMUFD and CONFIG_VFIO_DEVICE_CDEV
https://docs.kernel.org/driver-api/vfio.html#vfio-device-cdev

It can be complex to identify what is missing when trying to use it. This series
gives hints to user about it.

Suggested on:
https://lore.kernel.org/qemu-devel/0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org/

Tested using a cross compiled QEMU and a custom kernel + debian rootfs [1].

[1] https://github.com/p-b-o/qemu-linux-stack/tree/device_passthrough

v2
--

- Move /dev/iommu to iommufd_backend_complete, so we can report the error
  instead of aborting.

Pierrick Bouvier (2):
  backends/iommufd.c: report error when /dev/iommu is not available
  hw/vfio/iommufd.c: report hint to user when vfio-dev/vfio*/dev is
    missing

 backends/iommufd.c | 6 ++++++
 hw/vfio/iommufd.c  | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.47.3


