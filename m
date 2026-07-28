Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9C3C54F56
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonTM-00047k-Jh; Tue, 28 Jul 2026 15:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSY-0003cR-T9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:29 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSW-0001dd-1L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:26 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381b831d535so269115a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266842; x=1785871642; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
 b=aA461d18SCgxJJPLdJpLmuedoq8/77lD+ZTGHV92ZIUr2ok8EZlJAHK9K08Le6vy1d
 ZbuYi1m/OBmMf7qkJSiblzt3OcMzqejZ9fN/+EWMcJxuYYoX+Aci+sd06lNRrN826LaX
 tECLnSZMkHcNfPJsrwKc+/RsG0/WhcxXduSD6TskeCAywyW67TfzIOfKJXviAB6tmmbT
 ftxwe7Q/GCZQs4t3XAUrJSe4RZTs2clSMc5vGaFL5AiraxdE9mYvRdXFHXFby2WQRSAe
 K9TQzpqrAGjaHnHuk235Nc7l3HWg309NRtJaSF5zj20x81p7tpDHGGTdyLF3ofZmhE7j
 m6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266842; x=1785871642;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
 b=C0YQ2rprYfJHmcJZskJSz/JjO7lTwt+cc4Y6xHe7dEheSvNv5LAeIYTyJPFINatnsH
 C+q8kBnNQnK6G4McKdgtoHaU51vjwHLeL3PIukAHMFbFgv/lkL8GUQNW+YUhOqVQc6or
 HiSVJQaQIK5Ct/ROKDAAdldpamxEVvtkUG6nnF5hpdLvSNEJQvLbUAPKtSZIX8bqrEEy
 LgGggQw6yxuk22tNOjlretmuhxV1R8FOwC2NEzECo8KFZeQjmDSoEzVBDXkywb7CGyT6
 uWEnv4f0LKqqhOl8rCARsJne7eVtxLIgPrm74UdC36qeUeEPUesNKILSJaZQKO2c/eGT
 ZgFQ==
X-Gm-Message-State: AOJu0YxT92HicgNWRWFhVFwKSaRu0B8pJa11w2Z5c9F/Ho+d6Z5dV31S
 W+7RpRcPM5rhrH9FF83zh0AE0WNrrDzQri2ZU1ha7GwOArTtcWH1ft6ZFdAYMRtLUpw=
X-Gm-Gg: AR+sD11bVn0prGUSbZ5ESG42Dte0OTftNkZv79NOCfBuBV+bYi0+ermoWoAmK2/f/3o
 wPviFhgUNeLTyNqJyN1LmpsfRLBk/3b/3ku39pEWCxphe9kEWMC9cNol5y1aSixe3OaJkgy3R2r
 90/bVDdxQ0/4AKKyYSKZsImA7axzMmQBiaULrd5EcE+sfzNrZ6lfP76Zg+XlPoZ1VP93TXleoRr
 2fxchE9/oaQWfe74gm3mqWWGtRA+So2DyrhUep0TbbBRNehZMV4I9viwpWy0duYEC4wKpOvCreR
 PnFq+tDZQTthzc+P97BxlukUi0rtdA6BE1F3nHbC1vGPf7QILU0CRhi3/sBTwDnRiTVzwCiEszX
 oMthXxt7FV+R1iUdf7Hm54h/seYZoXiqLum5iycJA+fk0g7Al871e6kFWLa1CaF2To1Vf2xbVy+
 tOWz4hb5WSS/KtVCb1WKS4AlRf6zHI
X-Received: by 2002:a17:90b:390b:b0:38e:2f21:3bb5 with SMTP id
 98e67ed59e1d1-38f6a4e3667mr4131018a91.21.1785266842244; 
 Tue, 28 Jul 2026 12:27:22 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:21 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 22/24] docs/interop/firmware.json: Add arm-rme firmware
 feature
Date: Tue, 28 Jul 2026 13:26:28 -0600
Message-ID: <20260728192630.240375-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Some distributions provide packages continaing firmware to be run under
QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
contain descriptors in /usr/share/qemu/firmware/*.json listing the
firmware features, so that environments like libvirt can figure out
which firmware they can load.

Define an optional feature for arm64 firmware to indicate that a
firmware supports running in a Realm. Firmware implementations need
extra support for running in a Realm, in particular to distinguish
shared from private guest memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/interop/firmware.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5ed4..2850b91078d9 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -161,6 +161,9 @@
 #     options related to this feature are documented in
 #     "docs/system/i386/amd-memory-encryption.rst".
 #
+# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
+#     Management Extension (RME).
+#
 # @intel-tdx: The firmware supports running under Intel Trust Domain
 #     Extensions (TDX).
 #
@@ -229,7 +232,7 @@
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
-             'intel-tdx',
+             'arm-rme', 'intel-tdx',
              'enrolled-keys', 'requires-smm',
              'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
-- 
2.43.0


