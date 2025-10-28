Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9846DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnaq-0005to-Nv; Tue, 28 Oct 2025 13:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnap-0005rd-EX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnal-0004PK-Ns
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kN94O/gSwiS6ZhzPvyUBL4OCox4bKst3ai6S8h1NEE=;
 b=cC+1A+r2XvdoZhISWrToIW+akum49+SarTls5hBgHUJLTp8jBJAHl7nNNyN4Pelf4hU/TY
 qredpxcAQdRaqmyv/iaubxc435xQ4abf2W5RpVNzSfk4/RhbMO95b2ca1fNa3kT5yGPKCG
 dulGINnCNZ8OeeztHkim8U4LAZvHito=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-p7c5qCrKOUS1WmAD_4djnA-1; Tue, 28 Oct 2025 13:34:37 -0400
X-MC-Unique: p7c5qCrKOUS1WmAD_4djnA-1
X-Mimecast-MFC-AGG-ID: p7c5qCrKOUS1WmAD_4djnA_1761672876
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477113a50fcso23806435e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672875; x=1762277675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kN94O/gSwiS6ZhzPvyUBL4OCox4bKst3ai6S8h1NEE=;
 b=uUa0ZDSUJOJ+FyjxQjx+vJDi0vYNY2lR0cMkqKBn47eu+Ohp2KfyahaYY+4AvH6rGs
 OUujZfjzkVJ6V3jsN/OogqcvlytdZ9NTh5acayHcttx/DjLpRzgA9F8JUvSa826QALLu
 QATHou/jzWlYZCkIzxOnlbjeRwfJbwLXZXdY7qPu8HEdxK9a6RCK1CgzUYj5DQZmI9V9
 paF5mEHAyHIGBVDjUL8HITwBkhz3IeOm7qriasa3s/P68bn0zWN9UTOAZDdk6esRZ3rH
 6kFnR8dddAy86qyBzS1E7nh+khVXDz9RCa2nzB03umMTxtZNjqk3XfkOIBTBLeCTJshd
 62iQ==
X-Gm-Message-State: AOJu0Yy0Tfmomb4OaJrI575rOuZBgISFQ0LTSyuxF37qFvMwj+p7IimI
 7ZPKYZDdvVYQN8b2+CogVH3h5XYYMSsNBWey4C+lHwzPjwRhYDj8KekNq/FN3GVQL7KFSsS/MQ7
 cglzuAve7PFJR+ktgAjcx7RRxYmVl6rF+GEmdXDVi7XjT5Ey4Y2y4b/NXQwiY7cEuhaWOEx5Fl9
 +UEl86Xfna/1PELW3yFMxupHXlczx7R3eHtXc+CjFh
X-Gm-Gg: ASbGncuyaRmfTNyqgO1Hby+byJFTDG6QrcpeLZhmealQOJBOOl5Xtt00xUI9Z1gOwgE
 zBNblspwKCyblH1iE3tsQNZBgCIbgx5U6sBa+11/gfae+6/KvVcN8ObutQInaoCv6axUPDV6n+N
 lcW1kztmMi6nUQ5hfD1XhYYx2EyDruvS0KayjPF+AMRc9wOK2qHjXoZbcBFZQmgqbyM+emK2j+q
 ZZJkkwsoy/m16LMvi/xcUyNIKzDSebFtuyznzuTCQ06NbTtJShzc4gkIHPxqQE5nCn9VB+oIB9z
 hl0JwFcjRBnMfrg4SpAxXdnVGB/SebuNyCxZO9x1l1a6pW0vSb+vQNiE0As93k8ydlGsF3ffMk0
 OUPj6AngNYIOPBABn6AM/QzwTlMcluNyh2JbCII6Zut6Vs60isaV6LrmbUrNsd3n69Xj+KA+gIh
 UN4Kw=
X-Received: by 2002:a05:600c:37cd:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-4771e360859mr1992745e9.18.1761672875166; 
 Tue, 28 Oct 2025 10:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYw2wyUpgpgeo+kHYXrhRC3I5eOhcsTa8EWFoIYCygvPXkHMH07Ylt9zz0KWw+YAXHaoU88A==
X-Received: by 2002:a05:600c:37cd:b0:46e:1fb9:5497 with SMTP id
 5b1f17b1804b1-4771e360859mr1992495e9.18.1761672874636; 
 Tue, 28 Oct 2025 10:34:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e196a9asm3881965e9.7.2025.10.28.10.34.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:34:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] scripts: clean up meson-buildoptions.py
Date: Tue, 28 Oct 2025 18:34:13 +0100
Message-ID: <20251028173430.2180057-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix a few issues reported by flake8 and pylint, mostly parameter names
that shadow globals.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions.py | 51 +++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index a3e22471b2f..e636d258e8a 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -111,13 +111,13 @@ def help_line(left, opt, indent, long):
     right = f'{opt["description"]}'
     if long:
         value = get_help(opt)
-        if value != "auto" and value != "":
+        if value not in {"", "auto"}:
             right += f" [{value}]"
     if "choices" in opt and long:
         choices = "/".join(sorted(opt["choices"]))
         right += f" (choices: {choices})"
-    for x in wrap("  " + left, right, indent):
-        sh_print(x)
+    for line in wrap("  " + left, right, indent):
+        sh_print(line)
 
 
 # Return whether the option (a dictionary) can be used with
@@ -144,18 +144,18 @@ def require_arg(opt):
     return not ({"enabled", "disabled"}.intersection(opt["choices"]))
 
 
-def filter_options(json):
-    if ":" in json["name"]:
+def filter_options(opt):
+    if ":" in opt["name"]:
         return False
-    if json["section"] == "user":
-        return json["name"] not in SKIP_OPTIONS
+    if opt["section"] == "user":
+        return opt["name"] not in SKIP_OPTIONS
     else:
-        return json["name"] in BUILTIN_OPTIONS
+        return opt["name"] in BUILTIN_OPTIONS
 
 
-def load_options(json):
-    json = [x for x in json if filter_options(x)]
-    return sorted(json, key=lambda x: x["name"])
+def load_options(opts):
+    opts = [opt for opt in opts if filter_options(opt)]
+    return sorted(opts, key=lambda opt: opt["name"])
 
 
 def cli_option(opt):
@@ -223,7 +223,7 @@ def print_parse(options):
         key = cli_option(opt)
         name = opt["name"]
         if require_arg(opt):
-            if opt["type"] == "array" and not "choices" in opt:
+            if opt["type"] == "array" and "choices" not in opt:
                 print(f'    --{key}=*) quote_sh "-D{name}=$(meson_option_build_array $2)" ;;')
             else:
                 print(f'    --{key}=*) quote_sh "-D{name}=$2" ;;')
@@ -241,14 +241,19 @@ def print_parse(options):
     print("  esac")
     print("}")
 
-json_data = sys.stdin.read()
-try:
-    options = load_options(json.loads(json_data))
-except:
-    print("Failure in scripts/meson-buildoptions.py parsing stdin as json",
-          file=sys.stderr)
-    print(json_data, file=sys.stderr)
-    sys.exit(1)
-print("# This file is generated by meson-buildoptions.py, do not edit!")
-print_help(options)
-print_parse(options)
+
+def main():
+    json_data = sys.stdin.read()
+    try:
+        options = load_options(json.loads(json_data))
+    except:
+        print("Failure in scripts/meson-buildoptions.py parsing stdin as json",
+              file=sys.stderr)
+        print(json_data, file=sys.stderr)
+        sys.exit(1)
+    print("# This file is generated by meson-buildoptions.py, do not edit!")
+    print_help(options)
+    print_parse(options)
+
+
+sys.exit(main())
-- 
2.51.1


