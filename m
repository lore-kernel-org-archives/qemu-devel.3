Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC64109022B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Dpn-0006OR-GP; Thu, 19 Mar 2026 09:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dp4-0005rx-VG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dp2-0001Bb-At
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxfUlYvRhQQX4MoWCMkv8SkJv+/DpoVuRBZT3qErhg0=;
 b=KTFPQcIt4nXo4FUWz6783fMrCIA+hNjgI9Gv/8Ocpk/9vO9aL4E0gUEGJdI3+T2VzGNWjX
 hzgcyW8u1wuXBT4YcucNlF3RFv/8ahjHGfLHRT14zbo8JoupuQIdyI9wxqZFpQshbqTlPv
 MLAuR7jU/LHM8LfzLIxk+4t3ize1R6Y=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-W3oSUbCiMnaymjgZiS4lCg-1; Thu, 19 Mar 2026 09:53:58 -0400
X-MC-Unique: W3oSUbCiMnaymjgZiS4lCg-1
X-Mimecast-MFC-AGG-ID: W3oSUbCiMnaymjgZiS4lCg_1773928437
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b059ab124dso17492035ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928437; x=1774533237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxfUlYvRhQQX4MoWCMkv8SkJv+/DpoVuRBZT3qErhg0=;
 b=jX+aLMwQnLqWUmPMsfi+6oR3GnT9CbRAafoIT05//0IkISHJVqdSw7hL5Z2wlDfBi0
 6MVeyWW5s0zeBbKWG4AAw+3l3Q3H9RgVJnlmy54SesOvmW0WpFgA/KVtsSZDJBrzZkiD
 ErrKJ5c5nkmPRjeQMpKcVnVWp69Fev0VG+2e69qHDQGMy5l2fbAo+nHDm+0xa+UOL0lh
 dJzXHpuc6Kx/oCznKJwoEms0J7AuiWlNWF722G0ReluT1DtlNZZvKdSoIuYCe4Ep0s82
 JFjEVvmk7TxvFzvT0Rc2bLbWR3Z2f+Peh2P1Dn9d7sRta3d+gp9wiPgAs/aGgkWYjoLV
 NabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928437; x=1774533237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kxfUlYvRhQQX4MoWCMkv8SkJv+/DpoVuRBZT3qErhg0=;
 b=NdXAJxk8tGW5tsXHzsayHtcT3e0BXMnCiaVz6aLblXkw46If6wWfvpgoMzcZCb/nmu
 hRXTZTjARbKOsKoAJu5t6ANZEdbxMgExrZWH/WGNq+ScKEx1mt/AKkkTDGz9kNFabrEX
 wzDwbtBZvY7/h/SIebF7l7qGWsFYcYC7AJhrGNdJTfv8M7hTm/QGbQzD0zDn0ojJKlqg
 NkjA0sc1iAVJffx90b3gCinqObIFyYogr0Af2WwIribeYDEihfLDf8GKGcl7oZ0W3FVL
 npQ32rSqSBiW6WhGVJxC/XZ+2oQWndw+evLX8usGrnEdjbfTdFlTo0zHY6EFViydoI/T
 MjoQ==
X-Gm-Message-State: AOJu0YwBmHt4RVVpRZLUW36zldEyQBFBO/mw8MfQGMSyiL4OljsKlKwE
 8ik1zzwvzghM104eJ8igGPrT+tz15XiZFQ9ExZ8WToFD4vv4X5nS1IAOUlSFgC4aqujpfAmTUO8
 HA0rCx/4ZLouohoZClSuWQnbV0wu6DX+M1UCstWANZYHDgFLoH/yc6+/tgJlGOvugAT2Vl2Aq8s
 nzKCrHZnz2+JreczhrY1SI8G0YhvmOM8zn+7lM8wQ=
X-Gm-Gg: ATEYQzwyPViCD2bymoNE4KSgDdAnruhR0J9TbCFktLpcY+b+MAHezoeQTfmtwQuBS2G
 ElWcmv2JIDHegEtF4jmdD6ZK4iGh9ARgujS0RlEzlmYr8l5gXPwTOAgxJmnnhMg9oRy4XFOfzVE
 h+oxlO62pSEia4IheyDMdXgVU6Wplpw7rjYYHB3KXv1g5N7aC9eNYN+ch352kn1iZzbzV70HhVa
 v4SX19Oh9XCxkvg9NNFB/aMrnJ1NDkBEKFdM/CydYwfvRHHUp4f8PmQIMh9YPzBFG9BGWagEfWx
 sao7aShm3Q4zU72hksysMH1yqZGKyxAJzzW4H68GPzScat1GYzpYz2P+X6kjQA+QD1WNsppOhJ7
 M//8GnzeBQuszO7/XF6eo4pXGBwkKEGvWr1eV7WSLs9I6Y/s51JbAuwOfMhXkNA==
X-Received: by 2002:a17:903:3510:b0:2ae:4f6a:d2e6 with SMTP id
 d9443c01a7336-2b06e33b9f3mr59986955ad.20.1773928437169; 
 Thu, 19 Mar 2026 06:53:57 -0700 (PDT)
X-Received: by 2002:a17:903:3510:b0:2ae:4f6a:d2e6 with SMTP id
 d9443c01a7336-2b06e33b9f3mr59986565ad.20.1773928436467; 
 Thu, 19 Mar 2026 06:53:56 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:56 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC v2 7/7] hw/tpm: Increase TPM TIS max buffer size to 8192
Date: Thu, 19 Mar 2026 19:23:16 +0530
Message-ID: <20260319135316.37412-8-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

- Double the size from 4096 to 8192 so that we can have bigger buffer
  enabling support for PQC algorithms in the TPM TIS interface.
- v185 of TCG TPM rolls out PQC algorithm support. [1]

[1] section 46 https://members.trustedcomputinggroup.org/wg/TCG/document/previewpdf/45151

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/tpm/tpm_tis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66..0df35d5a54 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -33,7 +33,7 @@
 
 #define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
 
-#define TPM_TIS_BUFFER_MAX          4096
+#define TPM_TIS_BUFFER_MAX          8192
 
 typedef enum {
     TPM_TIS_STATE_IDLE = 0,
-- 
2.53.0


