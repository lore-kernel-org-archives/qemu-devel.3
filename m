Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728DCD74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIpF-0001iB-KD; Fri, 23 Jan 2026 10:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInW-00078O-4g
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInS-00037Y-WE
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47eddddcdcfso14171195e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769181001; x=1769785801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p02jhIrgK2AlS8/sbyLkAFwAYh/TNkGIGrDj8xF3nHM=;
 b=b36s7vd6k4h4/r8lXWHw7up2/9fI0TQWk1XBGk8CkCon2uxHx+3ICA6lxVAxxc8D4j
 AJDtnIhy8JbVisVLMLEAn0AvN5F3b0d0Hs9KsE75Ia7TcfYYFrBALcpjxmUz5Pe6R281
 /S4YWCE+iUzKEY+d/A1ajX/rWHKW20s1D7kDE9d+S4xIWSDXcXplEedq3YaXZ6csvjJS
 s8zBVpbvF1ch7bc44R3Zhs3VNBRLJTs/gQZvMHWWahU1NnZwJ/8rU+nyDFLtk5QcEPBa
 5kRKySKRaANaLSC43bDgxCC3d6EcFJw+BkwQb/RFVFR2fDZQzB075+ae31OWhQpObYjf
 +nnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769181001; x=1769785801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p02jhIrgK2AlS8/sbyLkAFwAYh/TNkGIGrDj8xF3nHM=;
 b=iUafxMI9JxKFeSscxR5f06IJ/DvAmbi8KhoJ01uWC36CgeJ2bFW2ICCGOxZbCMvCnO
 znRtPwmc903ASzpVLGJQMI9ZTIFPOzYzDRoBOK+y9CKuNYR5UgsOEwJXSpoPFsEYSFIO
 Kguwn+Qh3c+24Z3VXJxEYZ+qSE0dVKJslKsHifuw3m4LMBzGt0YI5lwYE/Ebeu3SBwDz
 FrXG4CSPBMJ59cd/DKkfgNO7bbcQWbfzkAp2YwoSD3lXZGZRe70wG2nc6XZvSMRIQ7pv
 DvHiko24GeIvTg067GNyqkOZUEcsITcEG7Fqs2XDFnuLhEBv71EUg6lqwzfArWu77kt6
 s88Q==
X-Gm-Message-State: AOJu0Yx6TDh4k3rqsc2dln+IlMwMl6zn5M/RGvPTXyxKdK3V8WRCVRtz
 oGmWc6QTfx9EqC2wNO9Y2Chqvlvp2t9GZbvumy2/3zCO9/Zow0htzIo8KrF+OE1iYwakJ1wGKXE
 i5yGxT2s=
X-Gm-Gg: AZuq6aIkHMiAXrPkDPMBDVfJvamsJID4UvJNqZLtvswZJiIM+wUQJot2WQo1C7nPZLw
 46gg3UYgS4yushwXFVgxUg4Cwy1MgkKn1ZdRFthBsITsB6MItx3x1tYhA64eqhNuD9pIjXtTR2d
 5B7yA+7aKZ+8Y49ypitG4F0ZXnvDEnSDeqIG5bPWOgu+Vs5rhfG1GtErkK2hG7hKVKYAXjw4Mc9
 0ysxrzJItsJo87AJYtJnTa4v6AknPW8GtxFxk34x/u5ffnMDgDJwR1LiNHtvvsDkH/fTxbRAn0G
 Sm7DbUBrfnWaDKo/vsViq/Hqstlhof0CVaC5uB0SP9TJ1Olz1EUej8EhPiu6NLWkpkUoQeXxpmI
 73ijxl1ucwxNapI29lQrxbbw00gdC0nAZWbu2vsJd9gVeV2hRygGJyffvJIhDsJ1LWJgkvxuFBf
 reQtQNWTzghcVQhRjzLiwcluWJcDnbpj/1x6/7UG2me7L0Z4yrRod/
X-Received: by 2002:a05:600c:1e24:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-4804c9beb33mr47302985e9.27.1769181001161; 
 Fri, 23 Jan 2026 07:10:01 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.10.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:10:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/22] docs: avoid unintended mailto: hyperlinks
Date: Fri, 23 Jan 2026 15:09:38 +0000
Message-ID: <20260123150941.1877768-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

In rST documents, an '@' character in normal text or a parsed-literal is
assumed to be an email address and will result in a 'mailto:' hyperlink in
the generated HTML.  In several places we have mailto: hyperlinks that are
unintended nonsense; correct these by either escaping the @ character or
making the text use ``...`` preformatted rendering.

This commit covers only the simple cases which can be trivially fixed
with escaping or ``..``; the remaining cases will be handled in
separate commits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260115142629.665319-3-peter.maydell@linaro.org
---
 docs/devel/submitting-a-patch.rst     | 2 +-
 docs/system/device-url-syntax.rst.inc | 4 ++--
 docs/system/vnc-security.rst          | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
index dd1cf32ad3..5ccd09a397 100644
--- a/docs/devel/submitting-a-patch.rst
+++ b/docs/devel/submitting-a-patch.rst
@@ -18,7 +18,7 @@ one-shot fix, the bare minimum we ask is that:
 
    * - Check
      - Reason
-   * - Patches contain Signed-off-by: Your Name <author@email>
+   * - Patches contain ``Signed-off-by: Your Name <author@email>``
      - States you are legally able to contribute the code. See :ref:`patch_emails_must_include_a_signed_off_by_line`
    * - Sent as patch emails to ``qemu-devel@nongnu.org``
      - The project uses an email list based workflow. See :ref:`submitting_your_patches`
diff --git a/docs/system/device-url-syntax.rst.inc b/docs/system/device-url-syntax.rst.inc
index 43b5c2596b..aae65d138c 100644
--- a/docs/system/device-url-syntax.rst.inc
+++ b/docs/system/device-url-syntax.rst.inc
@@ -33,7 +33,7 @@ These are specified using a special URL syntax.
 
    .. parsed-literal::
 
-      |qemu_system| -drive file=iscsi://user%password@192.0.2.1/iqn.2001-04.com.example/1
+      |qemu_system| -drive file=iscsi://user%password\@192.0.2.1/iqn.2001-04.com.example/1
 
    Example (CHAP username/password via environment variables):
 
@@ -79,7 +79,7 @@ These are specified using a special URL syntax.
 
    .. parsed-literal::
 
-      |qemu_system| -drive file=ssh://user@host/path/to/disk.img
+      |qemu_system| -drive file=ssh://user\@host/path/to/disk.img
       |qemu_system| -drive file.driver=ssh,file.user=user,file.host=host,file.port=22,file.path=/path/to/disk.img
 
    Currently authentication must be done using ssh-agent. Other
diff --git a/docs/system/vnc-security.rst b/docs/system/vnc-security.rst
index 4c1769eeb8..97e94ff407 100644
--- a/docs/system/vnc-security.rst
+++ b/docs/system/vnc-security.rst
@@ -182,9 +182,9 @@ When not using TLS the recommended configuration is
 This says to use the 'GSSAPI' mechanism with the Kerberos v5 protocol,
 with the server principal stored in /etc/qemu/krb5.tab. For this to work
 the administrator of your KDC must generate a Kerberos principal for the
-server, with a name of 'qemu/somehost.example.com@EXAMPLE.COM' replacing
-'somehost.example.com' with the fully qualified host name of the machine
-running QEMU, and 'EXAMPLE.COM' with the Kerberos Realm.
+server, with a name of ``qemu/somehost.example.com@EXAMPLE.COM`` replacing
+``somehost.example.com`` with the fully qualified host name of the machine
+running QEMU, and ``EXAMPLE.COM`` with the Kerberos Realm.
 
 When using TLS, if username+password authentication is desired, then a
 reasonable configuration is
-- 
2.47.3


