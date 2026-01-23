Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A7D74EE7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIoA-0007ml-HG; Fri, 23 Jan 2026 10:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInW-00078P-4d
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInT-00037j-S7
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:05 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48039fdc8aeso12306225e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769181002; x=1769785802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/fXCaA5bXzHvSSDa/5l0SGDQ+8xhd8q1UpBSEVCLj+c=;
 b=a6Xw2ju8Fd7ER1PiQFzfNVNntF15C++7EJq/NIo/XLuKqzzVyrp1NhnDVwtyhpBQOb
 sT2tfmnDBnkVghsUC5iGN7rjm94HVwsHKJw0pnWZhoaPhYpCo0glI0oVczSlt+yYPZJE
 XVFeAqgbC19WwKfXHotbgk++tI7s7Fe4BHIk4s5COJdPukBtAWgzoi7b3KDLo9Hp5BKG
 g2zm4MBtbLekA3e3Apu7F/LzwZHIOuRo4AT4Md3tdKLy2IWLRy97Q/Hrlom6/SSIoz0P
 m+QoKlnjRxolUk2yIeztXhj+rC/QTH7DGpYHnBvu2aH4Y7bkW0GT5MIYkSxS49LwXnZU
 lnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181002; x=1769785802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/fXCaA5bXzHvSSDa/5l0SGDQ+8xhd8q1UpBSEVCLj+c=;
 b=GHL/2bPygGZeIzlsVNKj94Wj4OvnH04GVRymntm0f8C7NHMXx1Bq53UlaaekeDrVNy
 tnWEp1Ll6wzkpqT0FhvrzJYNeFX3zNZUeaGs9+b8IuWs8oDOck+pi5C5emrcv15Wa+30
 oJUitPOT/h5/wuffZkEONwZ4LS62RrHM6T9oze767iBQKQxLPF67HAS5AAuUkrebVDxt
 wu8+y+V0SLUGmSHEN92pmQnSX5ZoTzcWXr4ihdLAsKpQxq+ZgWv7DzB5gcP0ERlseaD8
 zLsSiprmvMn8/LmwFhWDMIht1tXxvUMYyWWfycariIGjOJ3Y38zGiC4CMMZlGBltRopp
 hy5g==
X-Gm-Message-State: AOJu0Yxhi0Lmd73TaRJBTQwAqSO1v6jUuJ/Wzma+AW/FKv5WEhk/TWfq
 CLYLvv2IKuCAlbDGL7wHFyzFPqVhVU5xu2TUkLYT/ovZ/X7JmfFyo2XhfBT2lWekYJa1LKHgA9d
 qOfj0h70=
X-Gm-Gg: AZuq6aLtwVQDZLM1m54WlNh6P0oEZixWK2g0MYvSmj6nG9gVA2pat0mlhHmN2Hi8/c4
 kIxDPTFwDlZvPTWkIIZUxSrCCtQhLgOLrVF+vgWxq7S/rlI4Dd+YV+mJ9uUh6DreHzaMJG3w/Vn
 r+UxIrnU75/NMnQXBkjhIvAvNNQG/Y2zbR+/IS0JSY+/OIqheGeoU8uTAN+KvLC0vP5VpNpgPam
 gCou1K9zlgCzZNOizBktXB3pESQ8wIr3a0QrpyZBfPhG/thV7mjnSXEBjeaPGrSC7Qj4GTwTUjv
 GtKQsTfe5FMCPnQ9f6Tg4nlWrV+juHYHHMASAKc7WjXt2alQasCk8g3kok9S6UZKYChuYrHYwF7
 23vgNrziZBV5MuhdmN2NASHnDLCx2ncEb69Q+tHsiUgrv8lenczCSLBqEvOpvI1tUqQPae2o6Q5
 fFBCDJvDiaykL5Tu2B+P6D+SPbDdHgPAgPzyLMpWHXp4Asu5IUKlse
X-Received: by 2002:a05:600c:6814:b0:480:46c6:bf4b with SMTP id
 5b1f17b1804b1-4804c943ea3mr54058645e9.5.1769181002041; 
 Fri, 23 Jan 2026 07:10:02 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.10.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:10:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/22] qemu-options.hx: Drop uses of @var
Date: Fri, 23 Jan 2026 15:09:39 +0000
Message-ID: <20260123150941.1877768-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

A few entries in qemu-options.hx use the syntax "my-option=@var{name}"
(or @var{} with no name specified) when documenting an option that takes
an argument. This syntax isn't consistently used, and the documentation
generation has no support for it: it just appears literally in the
HTML output.

Switch these uses to the more common "my-option=<name>". This also
doesn't have any particular support in the documentation generation
and so appears literally in the output, but it is a little less odd
looking to the end-user.

The other common pattern we have is "my-option=name" with no marking
at all that the right hand side of the '=' is not literal text;
using <> seems preferable to me, as it makes it more distinct from
cases where the right hand side is documenting that only certain
values are permitted, as in "my-option=on|off". This patch doesn't
do anything about existing uses of this pattern (except in one case
which was so confused as to use "my-option=@var{}" in the --help
output and "my-option=" in the RST output, where we change both
for consistency), but prefers not to add more of them.

We don't change the uses of @var in the colo-compare documentation,
as that part deserves a slightly more wide-ranging overhaul that
is better in its own commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260115142629.665319-4-peter.maydell@linaro.org
---
 qemu-options.hx | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 455b8be890..862b6c7661 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -36,7 +36,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
-    "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
+    "                memory-encryption=<id> memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
     "                spcr=on|off controls ACPI SPCR support (default=on)\n"
 #ifdef CONFIG_POSIX
@@ -100,7 +100,7 @@ SRST
     ``nvdimm=on|off``
         Enables or disables NVDIMM support. The default is off.
 
-    ``memory-encryption=``
+    ``memory-encryption=<id>``
         Memory encryption object to use. The default is none.
 
     ``hmat=on|off``
@@ -180,7 +180,7 @@ SRST
 
             -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
 
-    ``sgx-epc.0.memdev=@var{memid},sgx-epc.0.node=@var{numaid}``
+    ``sgx-epc.0.memdev=<memid>,sgx-epc.0.node=<numaid>``
         Define an SGX EPC section.
 
     ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
@@ -4530,7 +4530,7 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
     "                Policy for handling unstable management interfaces\n",
     QEMU_ARCH_ALL)
 SRST
-``-compat [deprecated-input=@var{input-policy}][,deprecated-output=@var{output-policy}]``
+``-compat [deprecated-input=<input-policy>][,deprecated-output=<output-policy>]``
     Set policy for handling deprecated management interfaces (experimental):
 
     ``deprecated-input=accept`` (default)
@@ -4546,7 +4546,7 @@ SRST
 
     Limitation: covers only syntactic aspects of QMP.
 
-``-compat [unstable-input=@var{input-policy}][,unstable-output=@var{output-policy}]``
+``-compat [unstable-input=<input-policy>][,unstable-output=<output-policy>]``
     Set policy for handling unstable management interfaces (experimental):
 
     ``unstable-input=accept`` (default)
-- 
2.47.3


