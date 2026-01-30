Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A01D73EB7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhRX-0002bA-6I; Fri, 30 Jan 2026 00:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vlhRS-0002Z1-17
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:53:14 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ckeong.teo17@gmail.com>)
 id 1vlhRC-0005xl-GR
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:53:12 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64937edbc9eso1588575d50.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 21:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769752374; cv=none;
 d=google.com; s=arc-20240605;
 b=SOMWxqcXT/WKx7xCepcKNgbhgOBpQR9Nagskb5o3AM1q+D7OIQn6FlrxgBL9+IdDCQ
 KdasnZmQnaDM+TnzUSjozwFU8hGAg/IJqo88WB4gqncDiQmw1Tf4g/hgUzieixR5dbG/
 kTxgXTsx+9k/3Fy8R7Absr/dv25IkYL9qX+DNXr5kOtsqmPwD16xurYrHg5OzrGa0HtC
 WzdFubLTh/QDmcTqhc4Mow2T4v9g6251WV+Rd8g6GQZ3ek3J1zXvsMgcw5hD6QfGHytG
 LzpHYm2OIk+5ZX4Mvi9ofDPMbA6dRoQ5Q5VN6ygNSEahNpCeWkrO4ox7S0Zx07gISE0y
 mZjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=O6rKoXfmWhWy93+DiHLbPlSO7k6MeDQxJP1rDit04KQ=;
 fh=625s+MvjTWGLwJlyYonIERWiDqlksGXQrsySXhBWWlA=;
 b=Myp5iK602ZlU3EqyEs9XZTSh26kT7WZz/QDhhIBo8EwEULSOIGWXa2hiz6A9JE5elw
 FVHzHKaKqgUWVclOPyejSYXcbvrTcQZ/IBiSMzcCfJ+9HGEn/7LCsJ9Nxurk8EYtBrPR
 9gQHQPUBW1KMvMYSHmXPN7vd8/UuTNTjMqWN29h3TIBpWvv8tZLDMT39Sh7Lfc98wN9T
 uIk+uNJbbqKZnnE9UShNKSPaRI7ffqYcFq102lp+J65PalsRHLSNizRduhYdWuLgvO7k
 4f7BYWtuCP/p5+GBv4A+ibUczOOI+DZtJl1XaqJhZh/Q3/VaT2DR5TaRw52ZAW8B+u7Q
 SzPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769752374; x=1770357174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O6rKoXfmWhWy93+DiHLbPlSO7k6MeDQxJP1rDit04KQ=;
 b=SH8SnjWLHGai97PWYWWUQDm0j49Vq7sk5UACgWdC6OjKCu3+fOCPZYTKIZiDpsnV0Z
 Q5SJxYGisw2fsusNbwUcRRoCMZm3Jqhld6nh2D4sad2vUUSC4bRuo8Z4EoSMnui6th7s
 /oRRYXveWrIX97eYgIJGhdS9JU6wa/GDBpnxm0Xko0ietslMjVnGq4/g0yqdTDAFJLg9
 5eHHN7cuTDzAG7kj8QZgGludK5R1oeMQ3CC7L2pEcQHXjBHEocOPxhTHhJy7wn0LMX40
 Rs6tSAfj0KiO4lHuZGYb24y8Yq51gWL3Ly5sfJSUX2DY/zqX8camR+/s7jjC5T4SSdv7
 MT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769752374; x=1770357174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6rKoXfmWhWy93+DiHLbPlSO7k6MeDQxJP1rDit04KQ=;
 b=fo6B50XqTI5Nos/TcW0naimjfD56zxLNnN/kBA+C1GMhBuQek1s9Z5EJnN0jn+3fq5
 cpg6CvXyRh6hl+Pl2+mImzd5vuiu3u14fvFdydY2ojTmZQfEtk6+6q6ztGaMos4k5LFS
 o0mZG9QXmQoFOS4DgxERvjoanlHGFhHL7dcsP9QZE2WjWwOwLXNxsTOEoLQJfBJhA4AR
 ZkXC/Oc0KBjGuVg00HbyIkNwvxm7NoOir0C2dCda9EFJbTwqPExlu9ds0wZMKa+BqtTP
 xojZ57QpcLDbY6Mj/YajwKvBH/YXGTb5boIuUPoG6CTL1PbXlLAu30QZ7RBbtGfy8xL6
 Pb/w==
X-Gm-Message-State: AOJu0YzA7Je7CKcFpSmi1rtuSHbcy3xVWfscJC0yKPF+4/B38kYAx6KM
 OpPIv3xrXZgBLXqRJrl+OQpsrruwGiGweYxYdca5gY/DPI9q4F2F3vOu+QFvb9nd35SRzEdLQ5g
 I0y9NhvfxLrgz8DogUGXnLGb3IA1hKPxJnJU7sZEMzA==
X-Gm-Gg: AZuq6aLEJie59O5sFQFvx4HsmhFgy3nYTyMqlB/15d50MO5eKvLiSiXwVU46s2fZCWG
 G3wGXyCRrByGZMrN+urrnN7djWcMWsT5y4xboQC8qaOSsdDkIXW62kcyOl2pNlQPSNPgh/qfEgU
 GZR8hUgwBn33KN3TT5u49DuaSW2knffJseLtHp3eibFsf/jXxsxZ3n1LzMJTpw633l9pAXNqnIM
 tJYsJjiAZTjTNb/edMOyYtxiLwDUYmesWt2ZBsPfWPHCoXLSJecDBrwwqqEIW2WSRPEbNB8+e4Y
 FbCB1F8mIw==
X-Received: by 2002:a53:cd07:0:b0:649:548a:d6c5 with SMTP id
 956f58d0204a3-649a83a5f79mr1238212d50.11.1769752374161; Thu, 29 Jan 2026
 21:52:54 -0800 (PST)
MIME-Version: 1.0
From: Choon Keong Teo <ckeong.teo17@gmail.com>
Date: Fri, 30 Jan 2026 13:52:43 +0800
X-Gm-Features: AZwV_QgR8HZeyjKqOJ9E2AWEY9VQYAsmNTVxwyt1zcICR8R8Y-Y7lwQAJH5hsG0
Message-ID: <CAOkKuiMh4A-7Jo2Zg98Js7cOpXCd7N_B1RUGUr7-=x-tU+=UYg@mail.gmail.com>
Subject: [Bite-Sized Task] Volunteer to Fix Issue #3193
To: qemu-devel@nongnu.org
Cc: jsonw@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=ckeong.teo17@gmail.com; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

My name is Choon Keong (please feel free to call me CK), and I am
currently a university student. I have been following the Bite-Sized
Tasks page and would like to volunteer to work on Issue #3193.

I have reviewed the mailing list archives and didn=E2=80=99t find any recen=
t
patches addressing this issue. I found that the property in question
was converted to a machine property in a previous refactor, but it was
not assigned a description string in hw/i386/pc.c, as noted by Peter
in the comments.

I am currently preparing a patch to add the missing description using
object_class_property_set_description. If possible, I would appreciate
being assigned this issue on GitLab.

Thank you for your time and guidance. I look forward to contributing!

Best regards,
Choon Keong.

