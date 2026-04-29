Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2198CCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI670-00019l-9F; Wed, 29 Apr 2026 10:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66x-00019B-Ed
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:42:00 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66o-0003AQ-9Y
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:56 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de4ebe10cbso5318812a34.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777473709; x=1778078509;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYJSJt9JHpwlXyOmzguxiYsp09gJ5H+HoAyeLEo5w9A=;
 b=H87D1WoHkD6DjWB/yF3UnR76wzWFboyjQNszD6YqjpE5zAF3zZi0+z8pd0Ns/CRb6A
 ztGULDY3Xw550Kxd7ipg+T4sQBch5dNr/6nnlXBiq7nhSVj9kmgcc93sUndUe8vhsDJd
 sx5VfsPF549kGgsuXF1eQ1/FWca4SD5qvLJAZIso8J8OQLUy6Yy7FH65KmUnP6zA8AIu
 rtuEyHPow4hLYj+e8JAZKe8Gik0eyoIrF/J/8yq0lCLhOAPmSEMWAVwqiKebOOxrtM7c
 ah+PamW92/PtPjktu94AX92BmhO7vCkI5c9ff413oJ8vh9eEZT/vaLD59T05KvVGwZjQ
 SvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473709; x=1778078509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZYJSJt9JHpwlXyOmzguxiYsp09gJ5H+HoAyeLEo5w9A=;
 b=adflYrVUKgld2YWIHtYW7lpciEQMy1MuDjxOed8oM0S0Vc4BBFvCERaId+5V5cPdn4
 KZEI4LcaWnvYZbR2+fv6jsLlehneBuFZhySy6p8KmEchYqRWZZ7fjfjUon/1ol0Gw0u1
 9PXitRbDJU9FAiT2f7aFi70dEscSpkPr95LlW+p8/it8XrF5mI9zLTocJY0OS2Kvw91j
 2COPCvMQHEWFSjUny/2WcfwkGMCJjoaUR2lyeOxq5xcsNpQ9rFFeI4CIyTZaK6Xyjc3e
 xBdm062Fiyp3rZ/cHy+oUxNVpP/vKboFrp4HnpBCYb6k6RTlqgDgwd21HcHNZ2Jz8/7I
 B+Bw==
X-Gm-Message-State: AOJu0YwcYKqZHzA7WrHOCxAJTJUJar5esUXfEGNbqD0s2g8IqJJmEArR
 NMcqG3SXxO10h7miCqP5kHu3HQc889x7Fwp7k3IVUEooKCOVKq9ouGWhQn4XnCXJYPf4ngTOCGp
 puwQJPgs=
X-Gm-Gg: AeBDieuIgwLH4Up5C8xuZX3OoUz6hCVqk4+mHAV50UYmatHBBefLJW7mePO4A2EIwE6
 IpzT//oyRzYimqHZZv5eaKwDdFr/5nHQOTUVgYCTMT7rn4/gqadrjK0l6A5WYEE2OeaKA61pvp8
 iNE8Fa4DYB5BmDYwPqMLikhI1L+ftnbxJMgdv8A91cb7X7HmzqmJKW4TvP6bPWOV+2FOzE8JE+N
 QuK+386QfxkGkIC/uAwoVDdNopWK79IDWM3okKh9qJlxM1c8hdm6CmvwLV6Z1bPnkFAjYXuJNML
 qPBnOK0BSwCdNfkRffQo0xnuvjIyNxW5eBmLug2ge1Axp+sF+pcIcCW6B5nHwpMkPifcReqOKyp
 gtHWsNn0r/MtX+3woBHC8+3Bo1IIvv7CLzVjcer0MpLFoAPIcE7mRCbHQzaGU0w9dniQq8QRvk5
 JeavaHV+ucOBjMTzYlugfo
X-Received: by 2002:a05:6830:6a8b:b0:7db:f6a1:3742 with SMTP id
 46e09a7af769-7de9a1661camr5140313a34.28.1777473708267; 
 Wed, 29 Apr 2026 07:41:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab9d6067sm1553377a34.22.2026.04.29.07.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:41:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:38:55 -0600
Subject: [PATCH v2 5/5] bsd-user: Regnerate strace.list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-syscall-nr-v2-5-67a8d09dc13e@bsdimp.com>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
In-Reply-To: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=50715; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=LaiLKuYQmYgwG2ap7oy+Af7T7tXdl6ffi8DmSiwNqBc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hhLzkqFQCWr0HoWGhzxGFhq0xxTfmfWsngwR
 pcr6yGssVCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIYSwAKCRBsHNEofbAR
 AK4kD/9roYgKtn37hgUbMG58u/fm/nFsh6qlT7CuvmjXKDmoxH3ADcDBnssdZq5Ij2q1hktyH0y
 PkangU6/h/rbABqmoH15+citK3AeXJSPbqG2Y3lV7Oyy63qBhfjiOSUnwcF39cN1KDS/VHAq95N
 sRQkwlTQ8/3doITaSTGcVKoizq4d8YesoIu6g2cHnpOjpoS9MRtNskall/X1GeEVOst4SC0aFc8
 7htzn9S/X7Che0Z5T6haS/M7535ZVF5OPIl5uSVshKctpP0ROetydjt+Y25UD/6z8xfcusuC16b
 MfQhS/A3ZfZJDnheJ4623kvolY3YKRXyww70jDjapyUuXKn51op0MXAlGiDCjL/1x35oiXpkCJT
 l19xPmU3xeqEEroi6Pfvi/redBGH7s+9VU9CS8YB35nAsPxaLe6uSvkRkRndpKIRzMX3/uteSPj
 Cw5VslUaVOhlNvEK34zyucOhcarjtjXsRaQdbTADXgSB4BebCyGw8S1I44VR1rNMaT7z3hQTkeo
 fTBmO+WUJ5hSfvLrB4NMUyihJtE3JP+2U0OikYbNtj3jIVK5Bkl5KlJdoEZIEw5Jsvy3p7xnWmb
 TlKGr52Q76nKuQUdFIQ6GQx1YZk9J+XIXUA4x6FU5sY+OfwAeCLvGm35X+eWc5LTOUpUb5ARK6Q
 w+jaN6SvL3M4aHQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Generate strace.list in a stable way. All FreeBSD system call numbers
are stable: they always and will forever mean only one thing (even if we
abandon a syscall number and remove the code from the kernel, we'll
never reuse it). System calls are the same across all architectures, and
newer versions just have more of them. Use the number in the generated
table so we can compile it on any version of FreeBSD.

Also include the script that I used to generate this. It requires the
FreeBSD source tree, which is why we can't use it to generate
strace.list. This depends on the FreeBSD source tree at the moment,
since it uses the same system call generation machinery that FreeBSD
uses to generate its system call tables, so we can't connect it to the
qemu build until that issue is corrected. We've had a terrible strace.list
for a while, and this will make it better (and there's serious issues
with strace, just like linux-user, so it's a little-used feature).

Note: I derived this script from one of the FreeBSD system call
generation scripts, so it needs to be BSD-2-Clause license, which
deviates a bit from the GPL-2.0-or-newer preference, but I think is OK
since it's not folded into the qemu binaries themselves (and output of
scripts is typically public domain, as is the case here). This script is
written in lua, but every FreeBSD installation has a 'flua' binary that
can run this script, and it leverages about 7k lines of library and
metadata FreeBSD maintains well.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/scripts/strace.lua | 117 ++++++
 bsd-user/freebsd/strace.list        | 708 ++++++++++++++++++++++--------------
 2 files changed, 556 insertions(+), 269 deletions(-)

diff --git a/bsd-user/freebsd/scripts/strace.lua b/bsd-user/freebsd/scripts/strace.lua
new file mode 100755
index 0000000000..c89e8e3aeb
--- /dev/null
+++ b/bsd-user/freebsd/scripts/strace.lua
@@ -0,0 +1,117 @@
+#!/usr/libexec/flua
+--
+-- SPDX-License-Identifier: BSD-2-Clause
+--
+-- Copyright (c) 2026 Warner Losh <imp@FreeBSD.org>
+-- Copyright (c) 2024 Tyler Baxter <agge@FreeBSD.org>
+-- Copyright (c) 2019 Kyle Evans <kevans@FreeBSD.org>
+--
+
+-- Add library root to the package path.
+local path = arg[0]:gsub("/[^/]+.lua$", "")
+package.path = package.path .. ";" .. path .. "/?.lua;" .. os.getenv('FREEBSD_SYSCALL_DIR') .. "/?.lua"
+
+local FreeBSDSyscall = require("core.freebsd-syscall")
+local generator = require("tools.generator")
+local config = require("config")
+
+-- File has not been decided yet; config will decide file.  Default defined as
+-- /dev/null.
+file = "/dev/stdout"
+
+function generate(tbl, config, fh)
+	-- Grab the master system calls table.
+	local s = tbl.syscalls
+
+	table.sort(s, function(a, b)
+	    return a.arg_alias < b.arg_alias
+	end)
+	-- Bind the generator to the parameter file.
+	local gen = generator:new({}, fh)
+	gen.storage_levels = {}	-- make sure storage is clear
+
+	-- Write the generated preamble.
+	gen:preamble("FreeBSD strace list\nNOTE: Use syscall numbers so we work on all the branches.")
+
+	for _, v in pairs(s) do
+		local c = v:compatLevel()
+
+		-- Handle non-compat:
+		if v:native() then
+			-- All these negation conditions are because (in
+			-- general) these are cases where code for sysproto.h
+			-- is not generated.
+			if not v.type.NOARGS and not v.type.NOPROTO and
+			    not v.type.NODEF then
+				fmt = "NULL"
+				fcn = "NULL"
+				if v.arg_alias == "__sysctl" then
+					fcn = "print_sysctl"
+				elseif v.arg_alias == "execve" or v.arg_alias == "fexecve" then
+					fcn = "print_execve"
+				elseif v.arg_alias == "ioctl" then
+					fcn = "print_ioctl"
+				elseif v.arg_alias == "mmap" then
+					fcn = "print_mmap"
+				elseif v.arg_alias == "sysarch" then
+					fcn = "print_sysarch"
+				elseif #v.args > 0 then
+					fmt = "\"%s("
+					for _, arg in ipairs(v.args) do
+						if arg.type == "char *" then
+							fmt = fmt .. "%s, "
+						elseif arg.type == "mode_t" then
+							fmt = fmt .. "%o, "
+						else
+							fmt = fmt .. "%#x, "
+						end
+					end
+					fmt = fmt:sub(1, -3)  .. ")\""
+				end
+				gen:write(string.format(
+				    "{ %d, \"%s\", %s, %s, NULL },\n",
+				    v.num, v.arg_alias, fmt, fcn))
+			end
+		-- Handle compat (everything >= FREEBSD9):
+		elseif c >= 9 then
+			local idx = c * 10
+			if not v.type.NOARGS and not v.type.NOPROTO and
+			    not v.type.NODEF then
+				fmt = "NULL"
+				if #v.args > 0 then
+					fmt = "\"%s("
+					for _, arg in ipairs(v.args) do
+						if arg.type == "char *" then
+							fmt = fmt .. "%s, "
+						elseif arg.type == "mode_t" then
+							fmt = fmt .. "%o, "
+						else
+							fmt = fmt .. "%#x, "
+						end
+					end
+					fmt = fmt:sub(1, -3)  .. ")\""
+				end
+				gen:write(string.format(
+				    "{ %d, \"%s\", %s, %s, NULL },\n",
+				    v.num, v.arg_alias, fmt, fcn))
+			end
+		end
+		-- Do nothing for obsolete, unimplemented, and reserved.
+	end
+end
+
+
+if #arg < 1 or #arg > 2 then
+	error("usage: " .. arg[0] .. " syscall.master")
+end
+
+local sysfile = arg[1]
+
+config.merge(None)
+config.mergeCompat()
+
+-- The parsed system call table.
+local tbl = FreeBSDSyscall:new{sysfile = sysfile, config = config}
+
+file = arg[2] or "/dev/stdout"
+generate(tbl, config, file)
diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.list
index d7f61f480e..2c4176475a 100644
--- a/bsd-user/freebsd/strace.list
+++ b/bsd-user/freebsd/strace.list
@@ -1,273 +1,443 @@
 /*
- *  FreeBSD strace list
+ * FreeBSD strace list
+ * NOTE: Use syscall numbers so we work on all the branches.
  *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * DO NOT EDIT-- this file is automatically @generated.
  */
 
-{ TARGET_FREEBSD_NR___acl_aclcheck_fd, "__acl_aclcheck_fd", "%s(%d, %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_aclcheck_file, "__acl_aclcheck_file", "%s(\"%s\", %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_aclcheck_link, "__acl_aclcheck_link", "%s(\"%s\", %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_delete_fd, "__acl_delete_fd", "%s(%d, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_delete_file, "__acl_delete_file", "%s(\"%s\", %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_delete_link, "__acl_delete_link", "%s(\"%s\", %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_get_fd, "__acl_get_fd", "%s(%d, %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_get_file, "__acl_get_file", "%s(\"%s\", %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_get_link, "__acl_get_link", "%s(\"%s\", %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_set_fd, "__acl_set_fd", "%s(%d, %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_set_file, "__acl_set_file", "%s(\"%s\", %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___acl_set_link, "__acl_set_link", "%s(\"%s\", %d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR___getcwd, "__getcwd", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR___semctl, "__semctl", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR___syscall, "__syscall", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR___sysctl, "__sysctl", NULL, print_sysctl, NULL },
-{ TARGET_FREEBSD_NR__umtx_op, "_umtx_op", "%s(%#x, %d, %d, %#x, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_accept, "accept", "%s(%d,%#x,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_accept4, "accept4", "%s(%d,%d,%#x,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_access, "access", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_acct, "acct", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_adjtime, "adjtime", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_bind, "bind", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_bindat, "bindat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_break, "break", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_enter, "cap_enter", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_fcntls_get, "cap_fcntls_get", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_fcntls_limit, "cap_fcntls_limit", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_getmode, "cap_getmode", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_ioctls_get, "cap_ioctls_get", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_ioctls_limit, "cap_ioctls_limit", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cap_rights_limit, "cap_rights_limit", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_chdir, "chdir", "%s(\"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_chflags, "chflags", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_chflagsat, "chflagsat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_chmod, "chmod", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_chown, "chown", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_chroot, "chroot", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_clock_getres, "clock_getres", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_clock_gettime, "clock_gettime", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_clock_settime, "clock_settime", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_close, "close", "%s(%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_connect, "connect", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_connectat, "connectat", "%s(%d,%d,%#x,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_cpuset_getdomain, "cpuset_getdomain", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_cpuset_setdomain, "cpuset_setdomain", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_dup, "dup", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_dup2, "dup2", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_eaccess, "eaccess", "%s(\"%s\",%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_execve, "execve", NULL, print_execve, NULL },
-{ TARGET_FREEBSD_NR_exit, "exit", "%s(%d)\n", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattrctl, "extattrctl", "%s(\"%s\", %d, \"%s\", %d, \"%s\"", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_delete_fd, "extattr_delete_fd", "%s(%d, %d, \"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_delete_file, "extattr_delete_file", "%s(\"%s\", %d, \"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_delete_link, "extattr_delete_link", "%s(\"%s\", %d, \"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_get_fd, "extattr_get_fd", "%s(%d, %d, \"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_get_file, "extattr_get_file", "%s(\"%s\", %d, \"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_get_file, "extattr_get_link", "%s(\"%s\", %d, \"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_list_fd, "extattr_list_fd", "%s(%d, %d, %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_list_file, "extattr_list_file", "%s(\"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_list_link, "extattr_list_link", "%s(\"%s\", %d, %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_set_fd, "extattr_set_fd", "%s(%d, %d, \"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_set_file, "extattr_set_file", "%s(\"%s\", %d, \"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_extattr_set_link, "extattr_set_link", "%s(\"%s\", %d, \"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_fchdir, "fchdir", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fchflags, "fchflags", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fchmod, "fchmod", "%s(%d,%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_fchown, "fchown", "%s(%d,%d,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_fcntl, "fcntl", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fdatasync, "fdatasync", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fexecve, "fexecve", NULL, print_execve, NULL },
-{ TARGET_FREEBSD_NR_fhopen, "fhopen", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fhstat, "fhstat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fhstatfs, "fhstatfs", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_fhstat, "freebsd11_fhstat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_fhstatfs, "freebsd11_fhstatfs", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_flock, "flock", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fork, "fork", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_fpathconf, "fpathconf", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_fstat, "fstat", "%s(%d,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_fstatat, "fstatat", "%s(%d,\"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_fstatfs, "fstatfs", "%s(%d,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_fstat, "freebsd11_fstat", "%s(%d,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_fstatat, "freebsd11_fstatat", "%s(%d,\"%s\", %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_fstatfs, "freebsd11_fstatfs", "%s(%d,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_fsync, "fsync", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ftruncate, "ftruncate", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_futimens, "futimens", "%s(%d,%p)", NULL, NULL },
-{ TARGET_FREEBSD_NR_futimes, "futimes", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getcontext, "getcontext", "%s(%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_getdirentries, "getdirentries", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_getdirentries, "freebsd11_getdirentries", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getegid, "getegid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_geteuid, "geteuid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_getfh, "getfh", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getfsstat, "getfsstat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_getfsstat, "freebsd11_getfsstat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getgid, "getgid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_getgroups, "getgroups", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getitimer, "getitimer", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getlogin, "getlogin", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getpeername, "getpeername", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getpgid, "getpgid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getpgrp, "getpgrp", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_getpid, "getpid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_getppid, "getppid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_getpriority, "getpriority", "%s(%#x,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_getrandom, "getrandom", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getresgid, "getresgid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getresuid, "getresuid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getrlimit, "getrlimit", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getrusage, "getrusage", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getsid, "getsid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getsockname, "getsockname", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getsockopt, "getsockopt", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_gettimeofday, "gettimeofday", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_getuid, "getuid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_ioctl, "ioctl", NULL, print_ioctl, NULL },
-{ TARGET_FREEBSD_NR_issetugid, "issetugid", "%s()", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_kevent, "freebsd11_kevent", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_kevent, "kevent", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_kill, "kill", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_kqueue, "kqueue", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ktrace, "ktrace", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_lchown, "lchown", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_link, "link", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_listen, "listen", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_lpathconf, "lpathconf", "%s(\"%s\", %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_lseek, "lseek", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_lstat, "freebsd11_lstat", "%s(\"%s\",%p)", NULL, NULL },
-{ TARGET_FREEBSD_NR_madvise, "madvise", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_mincore, "mincore", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_minherit, "minherit", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_mkdir, "mkdir", "%s(\"%s\",%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_mkfifo, "mkfifo", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_mknodat, "mknodat", "%s(%d, \"%s\",%#o,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_mknod, "freebsd11_mknod", "%s(\"%s\",%#o,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_mknodat, "freebsd11_mknodat", "%s(%d, \"%s\",%#o,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_mlock, "mlock", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_mlockall, "mlockall", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_mmap, "mmap", NULL, NULL, print_syscall_ret_addr },
-{ TARGET_FREEBSD_NR_mount, "mount", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_mprotect, "mprotect", "%s(%#x,%#x,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_msgctl, "msgctl", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_msgget, "msgget", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_msgrcv, "msgrcv", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_msgsnd, "msgsnd", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_msync, "msync", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_munlock, "munlock", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_munlockall, "munlockall", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_munmap, "munmap", "%s(%p,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_nanosleep, "nanosleep", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_nfssvc, "nfssvc", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_open, "open", "%s(\"%s\",%#x,%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_openat, "openat", "%s(%d, \"%s\",%#x,%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_pathconf, "pathconf", "%s(\"%s\", %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd10_pipe, "freebsd10_pipe", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_pipe2, "pipe2", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_poll, "poll", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_posix_fallocate, "posix_fallocate", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_pread, "pread", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_preadv, "preadv", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_profil, "profil", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ptrace, "ptrace", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_pwrite, "pwrite", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_pwritev, "pwritev", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_quotactl, "quotactl", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_read, "read", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_readlink, "readlink", "%s(\"%s\",%p,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_readv, "readv", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_reboot, "reboot", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_recvfrom, "recvfrom", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_recvmsg, "recvmsg", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_rename, "rename", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_revoke, "revoke", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_rfork, "rfork", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_rtprio_thread, "rtprio_thread", "%s(%d, %d, %p)", NULL, NULL },
-#ifdef TARGET_FREEBSD_NR_sbrk
-{ TARGET_FREEBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
-#endif
-{ TARGET_FREEBSD_NR_sched_get_priority_max, "sched_get_priority_max", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sched_get_priority_min, "sched_get_priority_min", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_select, "select", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_semget, "semget", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_semop, "semop", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sendmsg, "sendmsg", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sendto, "sendto", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setcontext, "setcontext", "%s(%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_setegid, "setegid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_seteuid, "seteuid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setgid, "setgid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setgroups, "setgroups", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setitimer, "setitimer", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setlogin, "setlogin", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setpgid, "setpgid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setpriority, "setpriority", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setregid, "setregid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setresgid, "setresgid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setresuid, "setresuid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setreuid, "setreuid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setrlimit, "setrlimit", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setsid, "setsid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setsockopt, "setsockopt", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_settimeofday, "settimeofday", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_setuid, "setuid", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_shmat, "shmat", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_shmctl, "shmctl", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_shmdt, "shmdt", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_shmget, "shmget", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_shutdown, "shutdown", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sigaction, "sigaction", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sigaltstack, "sigaltstack", "%s(%p,%p)", NULL, NULL },
-{ TARGET_FREEBSD_NR_sigpending, "sigpending", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sigprocmask, "sigprocmask", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sigreturn, "sigreturn", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sigsuspend, "sigsuspend", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_socket, "socket", "%s(%d,%d,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
-#ifdef TARGET_FREEBSD_NR_sstk
-{ TARGET_FREEBSD_NR_sstk, "sstk", NULL, NULL, NULL },
-#endif
-{ TARGET_FREEBSD_NR_freebsd11_stat, "freebsd11_stat", "%s(\"%s\",%p)", NULL, NULL },
-{ TARGET_FREEBSD_NR_freebsd11_statfs, "freebsd11_statfs", "%s(\"%s\",%p)", NULL, NULL },
-{ TARGET_FREEBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_sync, "sync", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_sysarch, "sysarch", NULL, print_sysarch, NULL },
-{ TARGET_FREEBSD_NR_syscall, "syscall", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ktimer_create, "timer_create" , NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ktimer_delete, "timer_delete" , NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ktimer_settime, "timer_settime" , NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ktimer_gettime, "timer_gettime" , NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_ktimer_getoverrun, "timer_getoverrun" , NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_create, "thr_create", "%s(%#x, %#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_exit, "thr_exit", "%s(%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_kill, "thr_kill", "%s(%d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_kill2, "thr_kill2", "%s(%d, %d, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_new, "thr_new", "%s(%#x, %d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_self, "thr_self", "%s(%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_set_name, "thr_set_name", "%s(%d, \"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_suspend, "thr_suspend", "%s(%d, %#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_thr_wake, "thr_wake", "%s(%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_truncate, "truncate", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_umask, "umask", "%s(%#o)", NULL, NULL },
-{ TARGET_FREEBSD_NR_unlink, "unlink", "%s(\"%s\")", NULL, NULL },
-{ TARGET_FREEBSD_NR_unmount, "unmount", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_utimes, "utimes", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_utimensat, "utimensat", "%s(%d,%s,%p,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_vfork, "vfork", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_wait4, "wait4", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_wait6, "wait6", NULL, NULL, NULL },
-{ TARGET_FREEBSD_NR_write, "write", "%s(%d,%#x,%d)", NULL, NULL },
-{ TARGET_FREEBSD_NR_writev, "writev", "%s(%d,%p,%#x)", NULL, NULL },
-{ TARGET_FREEBSD_NR_posix_openpt, "posix_openpt", "%s(%d)", NULL, NULL },
+{ 354, "__acl_aclcheck_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 353, "__acl_aclcheck_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 428, "__acl_aclcheck_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 352, "__acl_delete_fd_args", "%s(%#x, %#x)", NULL, NULL },
+{ 351, "__acl_delete_file_args", "%s(%#x, %#x)", NULL, NULL },
+{ 427, "__acl_delete_link_args", "%s(%#x, %#x)", NULL, NULL },
+{ 349, "__acl_get_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 347, "__acl_get_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 425, "__acl_get_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 350, "__acl_set_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 348, "__acl_set_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 426, "__acl_set_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 515, "__cap_rights_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 326, "__getcwd_args", "%s(%s, %#x)", NULL, NULL },
+{ 415, "__mac_execve_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 386, "__mac_get_fd_args", "%s(%#x, %#x)", NULL, NULL },
+{ 387, "__mac_get_file_args", "%s(%#x, %#x)", NULL, NULL },
+{ 410, "__mac_get_link_args", "%s(%#x, %#x)", NULL, NULL },
+{ 409, "__mac_get_pid_args", "%s(%#x, %#x)", NULL, NULL },
+{ 384, "__mac_get_proc_args", "%s(%#x)", NULL, NULL },
+{ 388, "__mac_set_fd_args", "%s(%#x, %#x)", NULL, NULL },
+{ 389, "__mac_set_file_args", "%s(%#x, %#x)", NULL, NULL },
+{ 411, "__mac_set_link_args", "%s(%#x, %#x)", NULL, NULL },
+{ 385, "__mac_set_proc_args", "%s(%#x)", NULL, NULL },
+{ 574, "__realpathat_args", "%s(%#x, %#x, %s, %#x, %#x)", NULL, NULL },
+{ 510, "__semctl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 374, "__setugid_args", "%s(%#x)", NULL, NULL },
+{ 577, "__specialfd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 202, "__sysctl_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 570, "__sysctlbyname_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 1, "_exit_args", "%s(%#x)", NULL, NULL },
+{ 454, "_umtx_op_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 463, "abort2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 541, "accept4_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 30, "accept_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 33, "access_args", "%s(%#x, %#x)", NULL, NULL },
+{ 51, "acct_args", "%s(%#x)", NULL, NULL },
+{ 140, "adjtime_args", "%s(%#x, %#x)", NULL, NULL },
+{ 377, "afs3_syscall_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 316, "aio_cancel_args", "%s(%#x, %#x)", NULL, NULL },
+{ 317, "aio_error_args", "%s(%#x)", NULL, NULL },
+{ 465, "aio_fsync_args", "%s(%#x, %#x)", NULL, NULL },
+{ 543, "aio_mlock_args", "%s(%#x)", NULL, NULL },
+{ 255, "aio_read_args", "%s(%#x)", NULL, NULL },
+{ 579, "aio_readv_args", "%s(%#x)", NULL, NULL },
+{ 314, "aio_return_args", "%s(%#x)", NULL, NULL },
+{ 315, "aio_suspend_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 359, "aio_waitcomplete_args", "%s(%#x, %#x)", NULL, NULL },
+{ 256, "aio_write_args", "%s(%#x)", NULL, NULL },
+{ 578, "aio_writev_args", "%s(%#x)", NULL, NULL },
+{ 445, "audit_args", "%s(%#x, %#x)", NULL, NULL },
+{ 453, "auditctl_args", "%s(%#x)", NULL, NULL },
+{ 446, "auditon_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 104, "bind_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 538, "bindat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 17, "break_args", "%s(%s)", NULL, NULL },
+{ 516, "cap_enter_args", NULL, NULL, NULL },
+{ 537, "cap_fcntls_get_args", "%s(%#x, %#x)", NULL, NULL },
+{ 536, "cap_fcntls_limit_args", "%s(%#x, %#x)", NULL, NULL },
+{ 517, "cap_getmode_args", "%s(%#x)", NULL, NULL },
+{ 535, "cap_ioctls_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 534, "cap_ioctls_limit_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 533, "cap_rights_limit_args", "%s(%#x, %#x)", NULL, NULL },
+{ 12, "chdir_args", "%s(%#x)", NULL, NULL },
+{ 34, "chflags_args", "%s(%#x, %#x)", NULL, NULL },
+{ 540, "chflagsat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 15, "chmod_args", "%s(%#x, %o)", NULL, NULL },
+{ 16, "chown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 61, "chroot_args", "%s(%#x)", NULL, NULL },
+{ 247, "clock_getcpuclockid2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 234, "clock_getres_args", "%s(%#x, %#x)", NULL, NULL },
+{ 232, "clock_gettime_args", "%s(%#x, %#x)", NULL, NULL },
+{ 244, "clock_nanosleep_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 233, "clock_settime_args", "%s(%#x, %#x)", NULL, NULL },
+{ 6, "close_args", "%s(%#x)", NULL, NULL },
+{ 575, "close_range_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 98, "connect_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 539, "connectat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 569, "copy_file_range_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 484, "cpuset_args", "%s(%#x)", NULL, NULL },
+{ 487, "cpuset_getaffinity_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 561, "cpuset_getdomain_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 486, "cpuset_getid_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 488, "cpuset_setaffinity_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 562, "cpuset_setdomain_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 485, "cpuset_setid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 90, "dup2_args", "%s(%#x, %#x)", NULL, NULL },
+{ 41, "dup_args", "%s(%#x)", NULL, NULL },
+{ 376, "eaccess_args", "%s(%#x, %#x)", NULL, NULL },
+{ 59, "execve_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 373, "extattr_delete_fd_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 358, "extattr_delete_file_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 414, "extattr_delete_link_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 372, "extattr_get_fd_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 357, "extattr_get_file_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 413, "extattr_get_link_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 437, "extattr_list_fd_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 438, "extattr_list_file_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 439, "extattr_list_link_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 371, "extattr_set_fd_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 356, "extattr_set_file_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 412, "extattr_set_link_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 355, "extattrctl_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 592, "exterrctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 489, "faccessat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 13, "fchdir_args", "%s(%#x)", NULL, NULL },
+{ 35, "fchflags_args", "%s(%#x, %#x)", NULL, NULL },
+{ 124, "fchmod_args", "%s(%#x, %o)", NULL, NULL },
+{ 490, "fchmodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
+{ 123, "fchown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 491, "fchownat_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 590, "fchroot_args", "%s(%#x)", NULL, NULL },
+{ 92, "fcntl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 550, "fdatasync_args", "%s(%#x)", NULL, NULL },
+{ 492, "fexecve_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 241, "ffclock_getcounter_args", "%s(%#x)", NULL, NULL },
+{ 243, "ffclock_getestimate_args", "%s(%#x)", NULL, NULL },
+{ 242, "ffclock_setestimate_args", "%s(%#x)", NULL, NULL },
+{ 565, "fhlink_args", "%s(%#x, %#x)", NULL, NULL },
+{ 566, "fhlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 298, "fhopen_args", "%s(%#x, %#x)", NULL, NULL },
+{ 567, "fhreadlink_args", "%s(%#x, %s, %#x)", NULL, NULL },
+{ 553, "fhstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 558, "fhstatfs_args", "%s(%#x, %#x)", NULL, NULL },
+{ 131, "flock_args", "%s(%#x, %#x)", NULL, NULL },
+{ 2, "fork_args", NULL, NULL, NULL },
+{ 192, "fpathconf_args", "%s(%#x, %#x)", NULL, NULL },
+{ 434, "freebsd10__umtx_lock_args", "%s(%#x)", NULL, NULL },
+{ 435, "freebsd10__umtx_unlock_args", "%s(%#x)", NULL, NULL },
+{ 42, "freebsd10_pipe_args", NULL, NULL, NULL },
+{ 299, "freebsd11_fhstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 398, "freebsd11_fhstatfs_args", "%s(%#x, %#x)", NULL, NULL },
+{ 189, "freebsd11_fstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 493, "freebsd11_fstatat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 397, "freebsd11_fstatfs_args", "%s(%#x, %#x)", NULL, NULL },
+{ 272, "freebsd11_getdents_args", "%s(%#x, %s, %#x)", NULL, NULL },
+{ 196, "freebsd11_getdirentries_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
+{ 395, "freebsd11_getfsstat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 363, "freebsd11_kevent_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 190, "freebsd11_lstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 14, "freebsd11_mknod_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 498, "freebsd11_mknodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
+{ 279, "freebsd11_nfstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 280, "freebsd11_nlstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 278, "freebsd11_nstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 188, "freebsd11_stat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 396, "freebsd11_statfs_args", "%s(%#x, %#x)", NULL, NULL },
+{ 72, "freebsd11_vadvise_args", "%s(%#x)", NULL, NULL },
+{ 509, "freebsd12_closefrom_args", "%s(%#x)", NULL, NULL },
+{ 482, "freebsd12_shm_open_args", "%s(%#x, %#x, %o)", NULL, NULL },
+{ 424, "freebsd13_swapoff_args", "%s(%#x)", NULL, NULL },
+{ 79, "freebsd14_getgroups_args", "%s(%#x, %#x)", NULL, NULL },
+{ 80, "freebsd14_setgroups_args", "%s(%#x, %#x)", NULL, NULL },
+{ 580, "fspacectl_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 551, "fstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 552, "fstatat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 556, "fstatfs_args", "%s(%#x, %#x)", NULL, NULL },
+{ 95, "fsync_args", "%s(%#x)", NULL, NULL },
+{ 480, "ftruncate_args", "%s(%#x, %#x)", NULL, NULL },
+{ 568, "funlinkat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 546, "futimens_args", "%s(%#x, %#x)", NULL, NULL },
+{ 206, "futimes_args", "%s(%#x, %#x)", NULL, NULL },
+{ 494, "futimesat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 451, "getaudit_addr_args", "%s(%#x, %#x)", NULL, NULL },
+{ 449, "getaudit_args", "%s(%#x)", NULL, NULL },
+{ 447, "getauid_args", "%s(%#x)", NULL, NULL },
+{ 421, "getcontext_args", "%s(%#x)", NULL, NULL },
+{ 554, "getdirentries_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
+{ 89, "getdtablesize_args", NULL, NULL, NULL },
+{ 43, "getegid_args", NULL, NULL, NULL },
+{ 25, "geteuid_args", NULL, NULL, NULL },
+{ 161, "getfh_args", "%s(%#x, %#x)", NULL, NULL },
+{ 564, "getfhat_args", "%s(%#x, %s, %#x, %#x)", NULL, NULL },
+{ 557, "getfsstat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 47, "getgid_args", NULL, NULL, NULL },
+{ 595, "getgroups_args", "%s(%#x, %#x)", NULL, NULL },
+{ 86, "getitimer_args", "%s(%#x, %#x)", NULL, NULL },
+{ 49, "getlogin_args", "%s(%s, %#x)", NULL, NULL },
+{ 523, "getloginclass_args", "%s(%s, %#x)", NULL, NULL },
+{ 31, "getpeername_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 207, "getpgid_args", "%s(%#x)", NULL, NULL },
+{ 81, "getpgrp_args", NULL, NULL, NULL },
+{ 20, "getpid_args", NULL, NULL, NULL },
+{ 39, "getppid_args", NULL, NULL, NULL },
+{ 100, "getpriority_args", "%s(%#x, %#x)", NULL, NULL },
+{ 563, "getrandom_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 361, "getresgid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 360, "getresuid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 194, "getrlimit_args", "%s(%#x, %#x)", NULL, NULL },
+{ 589, "getrlimitusage_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 117, "getrusage_args", "%s(%#x, %#x)", NULL, NULL },
+{ 310, "getsid_args", "%s(%#x)", NULL, NULL },
+{ 32, "getsockname_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 118, "getsockopt_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 116, "gettimeofday_args", "%s(%#x, %#x)", NULL, NULL },
+{ 24, "getuid_args", NULL, NULL, NULL },
+{ 593, "inotify_add_watch_at_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 594, "inotify_rm_watch_args", "%s(%#x, %#x)", NULL, NULL },
+{ 54, "ioctl_args", "%s(%#x, %#x, %s)", NULL, NULL },
+{ 253, "issetugid_args", NULL, NULL, NULL },
+{ 338, "jail_args", "%s(%#x)", NULL, NULL },
+{ 436, "jail_attach_args", "%s(%#x)", NULL, NULL },
+{ 597, "jail_attach_jd_args", "%s(%#x)", NULL, NULL },
+{ 506, "jail_get_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 508, "jail_remove_args", "%s(%#x)", NULL, NULL },
+{ 598, "jail_remove_jd_args", "%s(%#x)", NULL, NULL },
+{ 507, "jail_set_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 588, "kcmp_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 390, "kenv_args", "%s(%#x, %#x, %s, %#x)", NULL, NULL },
+{ 560, "kevent_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 599, "kexec_load_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 37, "kill_args", "%s(%#x, %#x)", NULL, NULL },
+{ 306, "kldfind_args", "%s(%#x)", NULL, NULL },
+{ 309, "kldfirstmod_args", "%s(%#x)", NULL, NULL },
+{ 304, "kldload_args", "%s(%#x)", NULL, NULL },
+{ 307, "kldnext_args", "%s(%#x)", NULL, NULL },
+{ 308, "kldstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 337, "kldsym_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 305, "kldunload_args", "%s(%#x)", NULL, NULL },
+{ 444, "kldunloadf_args", "%s(%#x, %#x)", NULL, NULL },
+{ 461, "kmq_notify_args", "%s(%#x, %#x)", NULL, NULL },
+{ 457, "kmq_open_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
+{ 458, "kmq_setattr_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 459, "kmq_timedreceive_args", "%s(%#x, %s, %#x, %#x, %#x)", NULL, NULL },
+{ 460, "kmq_timedsend_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 462, "kmq_unlink_args", "%s(%#x)", NULL, NULL },
+{ 362, "kqueue_args", NULL, NULL, NULL },
+{ 583, "kqueuex_args", "%s(%#x)", NULL, NULL },
+{ 400, "ksem_close_args", "%s(%#x)", NULL, NULL },
+{ 408, "ksem_destroy_args", "%s(%#x)", NULL, NULL },
+{ 407, "ksem_getvalue_args", "%s(%#x, %#x)", NULL, NULL },
+{ 404, "ksem_init_args", "%s(%#x, %#x)", NULL, NULL },
+{ 405, "ksem_open_args", "%s(%#x, %#x, %#x, %o, %#x)", NULL, NULL },
+{ 401, "ksem_post_args", "%s(%#x)", NULL, NULL },
+{ 441, "ksem_timedwait_args", "%s(%#x, %#x)", NULL, NULL },
+{ 403, "ksem_trywait_args", "%s(%#x)", NULL, NULL },
+{ 406, "ksem_unlink_args", "%s(%#x)", NULL, NULL },
+{ 402, "ksem_wait_args", "%s(%#x)", NULL, NULL },
+{ 235, "ktimer_create_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 236, "ktimer_delete_args", "%s(%#x)", NULL, NULL },
+{ 239, "ktimer_getoverrun_args", "%s(%#x)", NULL, NULL },
+{ 238, "ktimer_gettime_args", "%s(%#x, %#x)", NULL, NULL },
+{ 237, "ktimer_settime_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 45, "ktrace_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 391, "lchflags_args", "%s(%#x, %#x)", NULL, NULL },
+{ 274, "lchmod_args", "%s(%#x, %o)", NULL, NULL },
+{ 254, "lchown_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 160, "lgetfh_args", "%s(%#x, %#x)", NULL, NULL },
+{ 9, "link_args", "%s(%#x, %#x)", NULL, NULL },
+{ 495, "linkat_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 257, "lio_listio_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 106, "listen_args", "%s(%#x, %#x)", NULL, NULL },
+{ 513, "lpathconf_args", "%s(%#x, %#x)", NULL, NULL },
+{ 478, "lseek_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 276, "lutimes_args", "%s(%#x, %#x)", NULL, NULL },
+{ 394, "mac_syscall_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 75, "madvise_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 584, "membarrier_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 78, "mincore_args", "%s(%#x, %#x, %s)", NULL, NULL },
+{ 250, "minherit_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 136, "mkdir_args", "%s(%#x, %o)", NULL, NULL },
+{ 496, "mkdirat_args", "%s(%#x, %#x, %o)", NULL, NULL },
+{ 132, "mkfifo_args", "%s(%#x, %o)", NULL, NULL },
+{ 497, "mkfifoat_args", "%s(%#x, %#x, %o)", NULL, NULL },
+{ 559, "mknodat_args", "%s(%#x, %#x, %o, %#x)", NULL, NULL },
+{ 203, "mlock_args", "%s(%#x, %#x)", NULL, NULL },
+{ 324, "mlockall_args", "%s(%#x)", NULL, NULL },
+{ 477, "mmap_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 303, "modfind_args", "%s(%#x)", NULL, NULL },
+{ 302, "modfnext_args", "%s(%#x)", NULL, NULL },
+{ 300, "modnext_args", "%s(%#x)", NULL, NULL },
+{ 301, "modstat_args", "%s(%#x, %#x)", NULL, NULL },
+{ 21, "mount_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 74, "mprotect_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 511, "msgctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 225, "msgget_args", "%s(%#x, %#x)", NULL, NULL },
+{ 227, "msgrcv_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 226, "msgsnd_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 170, "msgsys_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 65, "msync_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 204, "munlock_args", "%s(%#x, %#x)", NULL, NULL },
+{ 325, "munlockall_args", NULL, NULL, NULL },
+{ 73, "munmap_args", "%s(%#x, %#x)", NULL, NULL },
+{ 240, "nanosleep_args", "%s(%#x, %#x)", NULL, NULL },
+{ 155, "nfssvc_args", "%s(%#x, %#x)", NULL, NULL },
+{ 154, "nlm_syscall_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 378, "nmount_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 339, "nnpfs_syscall_args", "%s(%#x, %s, %#x, %#x, %#x)", NULL, NULL },
+{ 176, "ntp_adjtime_args", "%s(%#x)", NULL, NULL },
+{ 248, "ntp_gettime_args", "%s(%#x)", NULL, NULL },
+{ 5, "open_args", "%s(%#x, %#x, %o)", NULL, NULL },
+{ 499, "openat_args", "%s(%#x, %#x, %#x, %o)", NULL, NULL },
+{ 191, "pathconf_args", "%s(%#x, %#x)", NULL, NULL },
+{ 518, "pdfork_args", "%s(%#x, %#x)", NULL, NULL },
+{ 520, "pdgetpid_args", "%s(%#x, %#x)", NULL, NULL },
+{ 519, "pdkill_args", "%s(%#x, %#x)", NULL, NULL },
+{ 600, "pdrfork_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 601, "pdwait_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 542, "pipe2_args", "%s(%#x, %#x)", NULL, NULL },
+{ 209, "poll_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 531, "posix_fadvise_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 530, "posix_fallocate_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 504, "posix_openpt_args", "%s(%#x)", NULL, NULL },
+{ 545, "ppoll_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 475, "pread_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 289, "preadv_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 544, "procctl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 44, "profil_args", "%s(%s, %#x, %#x, %#x)", NULL, NULL },
+{ 522, "pselect_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 26, "ptrace_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 476, "pwrite_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 290, "pwritev_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 148, "quotactl_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 528, "rctl_add_rule_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 527, "rctl_get_limits_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 525, "rctl_get_racct_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 526, "rctl_get_rules_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 529, "rctl_remove_rule_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 3, "read_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 58, "readlink_args", "%s(%#x, %s, %#x)", NULL, NULL },
+{ 500, "readlinkat_args", "%s(%#x, %#x, %s, %#x)", NULL, NULL },
+{ 120, "readv_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 55, "reboot_args", "%s(%#x)", NULL, NULL },
+{ 29, "recvfrom_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 27, "recvmsg_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 128, "rename_args", "%s(%#x, %#x)", NULL, NULL },
+{ 602, "renameat2_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 501, "renameat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 56, "revoke_args", "%s(%#x)", NULL, NULL },
+{ 251, "rfork_args", "%s(%#x)", NULL, NULL },
+{ 137, "rmdir_args", "%s(%#x)", NULL, NULL },
+{ 576, "rpctls_syscall_args", "%s(%#x)", NULL, NULL },
+{ 166, "rtprio_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 466, "rtprio_thread_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 332, "sched_get_priority_max_args", "%s(%#x)", NULL, NULL },
+{ 333, "sched_get_priority_min_args", "%s(%#x)", NULL, NULL },
+{ 581, "sched_getcpu_args", NULL, NULL, NULL },
+{ 328, "sched_getparam_args", "%s(%#x, %#x)", NULL, NULL },
+{ 330, "sched_getscheduler_args", "%s(%#x)", NULL, NULL },
+{ 334, "sched_rr_get_interval_args", "%s(%#x, %#x)", NULL, NULL },
+{ 327, "sched_setparam_args", "%s(%#x, %#x)", NULL, NULL },
+{ 329, "sched_setscheduler_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 331, "sched_yield_args", NULL, NULL, NULL },
+{ 474, "sctp_generic_recvmsg_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 472, "sctp_generic_sendmsg_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 473, "sctp_generic_sendmsg_iov_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 471, "sctp_peeloff_args", "%s(%#x, %#x)", NULL, NULL },
+{ 93, "select_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 221, "semget_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 222, "semop_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 169, "semsys_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 393, "sendfile_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 28, "sendmsg_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 133, "sendto_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 452, "setaudit_addr_args", "%s(%#x, %#x)", NULL, NULL },
+{ 450, "setaudit_args", "%s(%#x)", NULL, NULL },
+{ 448, "setauid_args", "%s(%#x)", NULL, NULL },
+{ 422, "setcontext_args", "%s(%#x)", NULL, NULL },
+{ 591, "setcred_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 182, "setegid_args", "%s(%#x)", NULL, NULL },
+{ 183, "seteuid_args", "%s(%#x)", NULL, NULL },
+{ 175, "setfib_args", "%s(%#x)", NULL, NULL },
+{ 181, "setgid_args", "%s(%#x)", NULL, NULL },
+{ 596, "setgroups_args", "%s(%#x, %#x)", NULL, NULL },
+{ 83, "setitimer_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 50, "setlogin_args", "%s(%#x)", NULL, NULL },
+{ 524, "setloginclass_args", "%s(%#x)", NULL, NULL },
+{ 82, "setpgid_args", "%s(%#x, %#x)", NULL, NULL },
+{ 96, "setpriority_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 127, "setregid_args", "%s(%#x, %#x)", NULL, NULL },
+{ 312, "setresgid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 311, "setresuid_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 126, "setreuid_args", "%s(%#x, %#x)", NULL, NULL },
+{ 195, "setrlimit_args", "%s(%#x, %#x)", NULL, NULL },
+{ 147, "setsid_args", NULL, NULL, NULL },
+{ 105, "setsockopt_args", "%s(%#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 122, "settimeofday_args", "%s(%#x, %#x)", NULL, NULL },
+{ 23, "setuid_args", "%s(%#x)", NULL, NULL },
+{ 571, "shm_open2_args", "%s(%#x, %#x, %o, %#x, %#x)", NULL, NULL },
+{ 572, "shm_rename_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 483, "shm_unlink_args", "%s(%#x)", NULL, NULL },
+{ 228, "shmat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 512, "shmctl_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 230, "shmdt_args", "%s(%#x)", NULL, NULL },
+{ 231, "shmget_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 171, "shmsys_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 134, "shutdown_args", "%s(%#x, %#x)", NULL, NULL },
+{ 416, "sigaction_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 53, "sigaltstack_args", "%s(%#x, %#x)", NULL, NULL },
+{ 573, "sigfastblock_args", "%s(%#x, %#x)", NULL, NULL },
+{ 343, "sigpending_args", "%s(%#x)", NULL, NULL },
+{ 340, "sigprocmask_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 456, "sigqueue_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 417, "sigreturn_args", "%s(%#x)", NULL, NULL },
+{ 341, "sigsuspend_args", "%s(%#x)", NULL, NULL },
+{ 345, "sigtimedwait_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 429, "sigwait_args", "%s(%#x, %#x)", NULL, NULL },
+{ 346, "sigwaitinfo_args", "%s(%#x, %#x)", NULL, NULL },
+{ 97, "socket_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 135, "socketpair_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 555, "statfs_args", "%s(%#x, %#x)", NULL, NULL },
+{ 423, "swapcontext_args", "%s(%#x, %#x)", NULL, NULL },
+{ 582, "swapoff_args", "%s(%#x, %#x)", NULL, NULL },
+{ 85, "swapon_args", "%s(%#x)", NULL, NULL },
+{ 57, "symlink_args", "%s(%#x, %#x)", NULL, NULL },
+{ 502, "symlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 36, "sync_args", NULL, NULL, NULL },
+{ 165, "sysarch_args", "%s(%#x, %s)", NULL, NULL },
+{ 430, "thr_create_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 431, "thr_exit_args", "%s(%#x)", NULL, NULL },
+{ 481, "thr_kill2_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 433, "thr_kill_args", "%s(%#x, %#x)", NULL, NULL },
+{ 455, "thr_new_args", "%s(%#x, %#x)", NULL, NULL },
+{ 432, "thr_self_args", "%s(%#x)", NULL, NULL },
+{ 464, "thr_set_name_args", "%s(%#x, %#x)", NULL, NULL },
+{ 442, "thr_suspend_args", "%s(%#x)", NULL, NULL },
+{ 443, "thr_wake_args", "%s(%#x)", NULL, NULL },
+{ 585, "timerfd_create_args", "%s(%#x, %#x)", NULL, NULL },
+{ 586, "timerfd_gettime_args", "%s(%#x, %#x)", NULL, NULL },
+{ 587, "timerfd_settime_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 479, "truncate_args", "%s(%#x, %#x)", NULL, NULL },
+{ 60, "umask_args", "%s(%o)", NULL, NULL },
+{ 205, "undelete_args", "%s(%#x)", NULL, NULL },
+{ 10, "unlink_args", "%s(%#x)", NULL, NULL },
+{ 503, "unlinkat_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 22, "unmount_args", "%s(%#x, %#x)", NULL, NULL },
+{ 547, "utimensat_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 138, "utimes_args", "%s(%#x, %#x)", NULL, NULL },
+{ 335, "utrace_args", "%s(%#x, %#x)", NULL, NULL },
+{ 392, "uuidgen_args", "%s(%#x, %#x)", NULL, NULL },
+{ 66, "vfork_args", NULL, NULL, NULL },
+{ 7, "wait4_args", "%s(%#x, %#x, %#x, %#x)", NULL, NULL },
+{ 532, "wait6_args", "%s(%#x, %#x, %#x, %#x, %#x, %#x)", NULL, NULL },
+{ 4, "write_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 121, "writev_args", "%s(%#x, %#x, %#x)", NULL, NULL },
+{ 321, "yield_args", NULL, NULL, NULL },

-- 
2.52.0


