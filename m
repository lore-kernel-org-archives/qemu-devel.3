Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC1FC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVBo-0000Mw-9d; Mon, 12 May 2025 11:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEVA3-0005LC-0X
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEVA1-0006oI-0n
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747064024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sp5AOlAAcMe/731mdhhjEGgBdH68SBKAgsxg0jZtfC0=;
 b=ZLhV6s6TKppuRuLYenE6+nl3ZJI7631kcnglxmT27u0I7ikIxJVXOvoEyWfHjehpK6kF72
 uysOdzlHmW67hCINvihnemJbXGQ1t1Vool6SobguwgpRg+UGUKwsMeEA/EkOJ10gATQIKf
 vjSqedISiPrT+rWQfZ8VNN6ChyaQkSI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ZVxMY9kaM3CA2JORIXWMew-1; Mon, 12 May 2025 11:33:43 -0400
X-MC-Unique: ZVxMY9kaM3CA2JORIXWMew-1
X-Mimecast-MFC-AGG-ID: ZVxMY9kaM3CA2JORIXWMew_1747064022
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cec217977so22774215e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 08:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747064020; x=1747668820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sp5AOlAAcMe/731mdhhjEGgBdH68SBKAgsxg0jZtfC0=;
 b=sS9Q9SPzBu3Tq9EcDBxrrSw2htVCgEQdqOZm324SvC361jNlipmCYIk6dFi1lwjI+x
 nCqYoOvO34w09TEtVqMBk+BrxKx9xMKwgJS9pLYL1SVUh+57Akpi/wjmNBRyLCSAfh1O
 ewRd+0N0mdmcLEsAPjj45N+3LaBm+CXQ6ucSYJHcJkDNWErpcSb2PnbVSMqGKxbPmZ3B
 Wg+mCTnoFdK22DaU+BOpS9ZM/ey0cHvquMfh4kvRsqpvsiMccLp0k9948y+fmMxUO+iR
 ohd3AUj0GhzgxBs41qrmgpoI5O4eD3SrrcuxHvkbPjaJTcnuAPxSWEiEMjdPJ8qTWmOu
 5KfQ==
X-Gm-Message-State: AOJu0YyvSZoIh7wtIdLjfBuqLw/n4hmLMllwevuC3SsCcS7iPG19PMXW
 3cEnwJm1eRvoFfu9iGcz45m9By39R9ROITCSsVqJNHyZUIAsQWeKhQBrt/I0dlAw753Py7w4VCZ
 1yeUjz976zjULL3ClNL4CUu0O/Adq0XpZNHLS4VKAVuwmK6+KJFY63kJl57hrEpv0rc6etSd84f
 uBPsp+eoLxwg/yicPlUg4fyd74HDx2kE+y2jgK
X-Gm-Gg: ASbGncvpE1TDMITrGkz3kdxGcaxpu74IzKzfBhsvZf/L7K4sHPEVGFRQWKGB8UAq3l5
 7qmvC8M5TTE8eCEXugZbjl++v5YPoq0ikYNJBMijLLfc4prSxWG29h1DzfeEeMz1PigASzRmINU
 cSrXuV1FvYCo3iAf0sHrWySqFG2rKpzd8eD168DIz7wCibIqAJZSZknLZd5714uxv9z7fEygRx2
 Z6FERjtJOA1RnaEcOoFR/ZlYHiNzxs3k/ryF9uXIOqzCcwqbvv5pV4dNKqi56Fs3tn3YSnFnI/b
 ySH8qJLaMBICh4o=
X-Received: by 2002:a05:600c:34d3:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-442d6dd21b4mr99989825e9.21.1747064019941; 
 Mon, 12 May 2025 08:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDIDSPNojxEA+YEREVIMoYzu/jSAWEdBb4SQz5359tn58loyctgmLk16cCw/EsEEHGpsY4fg==
X-Received: by 2002:a05:600c:34d3:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-442d6dd21b4mr99989545e9.21.1747064019520; 
 Mon, 12 May 2025 08:33:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.45.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d68585d1sm130686745e9.31.2025.05.12.08.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 08:33:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 0/2] rust: pl011: really use RX FIFO depth
Date: Mon, 12 May 2025 17:33:35 +0200
Message-ID: <20250512153337.153954-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Forward port a couple more commits from the C version and reintroduce
a comment that was lost.

Paolo Bonzini (2):
  migrate: allow smaller types
  rust: ci: do not enable full lint groups

 meson.build               |   3 ++
 migration/vmstate-types.c | 103 +++++++++++++++++++++++++-------------
 rust/Cargo.toml           |  45 ++++++++++++++++-
 3 files changed, 116 insertions(+), 35 deletions(-)

-- 
2.49.0


