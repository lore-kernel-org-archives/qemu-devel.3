Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BF6CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgaH-0001pQ-FD; Tue, 12 May 2026 02:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZk-00015e-FK
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:44 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgZh-0007zh-Vd
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:26:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3147071f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567195; x=1779171995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s1ugNJYOLmq0RMJfysTgh5azhOcAvfEAh2lvllhKwK4=;
 b=qHdKraGOPSSbyVrKeZqkBfdj4e7tG06EM+jO0NUHDrKN3F4R9F6l6VK1qK3gs7uQHe
 At+dO7UqY96m72asvAtcKtVarQs74cq0S6an7GS9vlzRebz8SGgQB9iOxRATPpn0mHIy
 SYpD79IcO14yJghXzbWtuc1ygC4qp8Li3q6o2c2ZlbU6QVFxAYfaWfellZe0T3TnwQy7
 LufT1CrQA5dk/5V8bFnXGRx5E5ZoIqSi8IGpT+fcTZ7yc4aUI8BzuYptR/eMVto9FkyF
 zGw1OLAOPDOtiyhM0BD7lcafDPWSawVxsI5hIYG99g/DAq0w77HozwJ5ASmotVPxoC8H
 p+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567195; x=1779171995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s1ugNJYOLmq0RMJfysTgh5azhOcAvfEAh2lvllhKwK4=;
 b=lqPAJYo3uYF9v19+Ie3xdOg3b7wG82COaRQ8Y/V1rB3vYqGgyFZ/Ifw7elXRRgKfUi
 geX17XUUGiIVDV0trEwjXXei5AvMllCL9qKOdjPH5v/y3+O8wpa9CM4SpiMFjs4Krm2k
 Chl69rSL9Nk4Bs9utrCIoQ1DDvSICKUIKYZBaaxw+j9Y/H8sba7HKWOI9Qe7lQqFpNrL
 69ecJ9nW6MwZHRWO3S780OVyqbZnUtZQSMxJL2oWLJhxCCfQ1l1dN0DO7wpPTVvs27J7
 FA/nJWq1xAh9w6FYDa/+Lac2VBj6ammOhyDu/D+PC6oDIYVkcV4eIVc3RekEmo6WHz/h
 4VHg==
X-Gm-Message-State: AOJu0Ywda68oPW6NvfcRLf/KYzsohyX+W9XOyKJ/4nzvlP1J1M5M21rs
 ckWHq/8l5NsnfGUsuf2JI0bszz2CaU9UsDyoOpF1lk/VSsi64cQiW08I99fcbCMlQFzuwVUAmV2
 RcKyks4o=
X-Gm-Gg: Acq92OG2oRSLo4xjFcsygJa3OaJKiV/r7yRP029H0syuO+7nJsYnxVC7lAMyaOCF72k
 NZjMOZsMpmGPwJzhwfDmYoBzQsazledyiYh9dIN3Jo+/eEahzY+DoZyjSc76vC1Lv2ZYZUXG7wM
 3V1DKCPGyQ40gtqp5iEf42GoCMx1ookQPrx18Q6K0qA4JlzMZtKMhJ9dDTpS3Ev8aAywVwwC5+2
 V5O9pPLSmUsq3xI9Ql2w9WNxjNAzhxJ780YLN1lzXCXrm5IEDjN2zqetS+BGFH/Qioy8XViqpkO
 Cexo4B4yn9kRGq3gWCgIm8SMKsdl8VW3TYWgrAf+cGV9+g4+yl2hIap4FLdL+6cvPStzzOzGDJs
 Br6oVi72ZUf1cir26aKF254iJHFDT/qb8+ro6RNEgQpvfDtaOci9pBeaKwr2E3FqLGFg5U1GCXg
 tDiM1HCf4Eqs8HIt/xJx1O1miSiyhf79jIxSyUM5DR0R8pYyEXwYI7FsyLA8bol2ZiDjiHk8FZ
X-Received: by 2002:a05:6000:24c3:b0:455:51cf:9f92 with SMTP id
 ffacd0b85a97d-45ac4224ea5mr3323033f8f.18.1778567195111; 
 Mon, 11 May 2026 23:26:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm31988196f8f.31.2026.05.11.23.26.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:26:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/41] scripts: strip leading './' when searching MAINTAINERS
 file
Date: Tue, 12 May 2026 08:21:42 +0200
Message-ID: <20260512062142.67998-42-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The following two uses of get_maintainer.pl should return the
same results, but do not:

  $ ./scripts/get_maintainer.pl -f ./hw/net/vmxnet3.c
  get_maintainer.pl: No maintainers found, printing recent contributors.
  get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

  "Philippe Mathieu-Daudé" <philmd@linaro.org> (commit_signer:4/7=57%)
  "Michael S. Tsirkin" <mst@redhat.com> (commit_signer:4/7=57%)
  Xiaoyao Li <xiaoyao.li@intel.com> (commit_signer:3/7=43%)
  Thomas Huth <thuth@redhat.com> (commit_signer:3/7=43%)
  Zhao Liu <zhao1.liu@intel.com> (commit_signer:3/7=43%)
  qemu-devel@nongnu.org (open list:All patches CC here)

  $ ./scripts/get_maintainer.pl -f hw/net/vmxnet3.c
  Dmitry Fleytman <dmitry.fleytman@gmail.com> (maintainer:VMware)
  Jason Wang <jasowang@redhat.com> (odd fixer:Network devices)
  qemu-devel@nongnu.org (open list:All patches CC here)

In the former case, the leading "./" needs to be removed before
trying to find a filename match.

Blindly stripping the "./" is valid because the script already
enforces that it is run from the QEMU git root directory, so
canonicalizing the filename vs $CWD is not required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260511093858.82753-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 00a0870b267..76be402e11e 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -384,6 +384,7 @@ foreach my $file (@ARGV) {
 	} elsif (!(stat $file)) {
 	    die "$P: file '${file}' not found: $!\n";
 	}
+	$file =~ s,^./,,;
     }
     if ($from_filename) {
 	push(@files, $file);
-- 
2.53.0


