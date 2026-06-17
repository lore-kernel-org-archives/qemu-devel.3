Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F4CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZsXu-0007bH-9L; Wed, 17 Jun 2026 11:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francismicheal037@gmail.com>)
 id 1wZsWL-0006u1-78
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:49:41 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francismicheal037@gmail.com>)
 id 1wZsWJ-0004C8-F2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:49:40 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-5176bbb9384so65019631cf.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 08:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781711377; cv=none;
 d=google.com; s=arc-20240605;
 b=P0n+B6sDmq8zqL9HYVlz3ohDGiHxvKrJHBnK4WD+QaDQQ+9BqVQ7iXorJtS2SCPo/+
 Bq9sxFBONwvDAegKxpidrQA8ZJzq9Kz+T6hIPA76GDuBlTbdOTBZujXGW+nFhkjpNnhF
 ti7gfPJsfcIaDxMd6166F+jFNrdHmKtTotwHV6VWm8zVSJfKLAOQdqp+4EIGIbS0w8FI
 Vloz7Ooqxo5dHGZ0NWCD9IfiOy6EhSS1rbdysOlc63YGr7HIkK47De4M0f0oLsT/hNTR
 lDwLe4MqIBWXlkMfvs2vqyMpQuCBjfDEsXozO6y3tk4G+r+Xe4AR9wxjeMkSUwADlECH
 EdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=vgkZUcJBj5KRl3T3MFk1fN6khSRKXu5c3ETov7HKigw=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=MQJcBLkIDXjVIRx5FZS7B24fH9DTwAL6q4nl9x2YLIHoUdNJjNJRR8ktfIdqVUpdK4
 8zlTY+yvmxQSBkWZEQVTAqdGIqFU84BzYgGwL7+AwxClgf5aCyub3kbyoUIMt+u5pdd6
 0s3Z6YIC9ytKWJxU8Vu7u/hUHZU0/hrEaLUyfZBCl+sAqXg8avetXNOTrqgOsKmTWXpR
 8VlyNSe754bDt+qQqXoa/6pV6cnfm/xKz5hFk9fj5vnJrM6qHCcqRCvCaC94q+zJfHkM
 8tZWltwhZkpl+kCNqBTMCiMkwReaoVBYp0yZeMwRuyhSBLJWsGyZ7oS+Br7nrODxYFoo
 pzpg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781711377; x=1782316177; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vgkZUcJBj5KRl3T3MFk1fN6khSRKXu5c3ETov7HKigw=;
 b=KCoGbg8R3stIfZyaWscAwNwko8vxS1U4/pyehTyY3rSOLqqoyK4IxiBMv48pVAFkXh
 CfDMvrDuUbRcXd/KKqrQlCpy0okIzo1YFhPG96E5Q+mqwI3CnxLqgCXf5DO8kk3nULS8
 P4GGVkMeM3fJlPNiSTR1ZFmvja/25VWxp3bVRnZPe0wmWrCH5A5UShkxkxi/JFTQgk1n
 dRLgb/Uoj/y65zYvKDkSKF6sE/cMHu4aGnGR6vPaAU1sTVB46Tdj177l4BnI1MRetqDO
 0ujC3Uf6Ywg//Wl5H0ArsFL9RHMe42nf6ilOy8wHDa7b2bHjpv/VA3lLdSj80l7QeFWa
 sENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711377; x=1782316177;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vgkZUcJBj5KRl3T3MFk1fN6khSRKXu5c3ETov7HKigw=;
 b=cl0dKHiGnz9qLrYBclkX9HZeoWntApJPESu/HO80u1noPLTkCtN5mZHOp0sz4IlCN2
 +VcynPGWWQM8Awdjx19cyiNL8X7I5nPJsZlglYUyK69FmVdM/LEjlJZmwA5ifET6UBLp
 CafGp0eG4/2TomNQGWQq/wFfe5EeiQhSc/fOvs+q1VNGzyx2QwE3Helv5wX9tVcEMR8Q
 dW4ZOsxRp54nK9bV8pVCtUwcPAyhoa6yhIy79+aDXQR4oUQepkRuYjBQ2ImaSQv8IUaC
 H4fBp/zRXHcD1Ik0U3UzkJSBokCH2eSr3U30jRJoHunGJC8M/sbp8nTLqXDuZIRrKZ1K
 p1hg==
X-Gm-Message-State: AOJu0YyNnE5NjcozShPRMhrsE59RjMqpNKxJR2CfyMsgoNJrlWVvlyj2
 AgqGjqN3GVsQF+9CUxslbhR1DXa4RJ8+B1skWkAk7eRoKETtDEJyvx0FTobtJ/sARZgoaBSaG7G
 MSXSd9/lBJ+GJyoxP9+SsrXcNT+u9naK6z9+OFtu0Kg==
X-Gm-Gg: Acq92OFPLOSORKj/1ss7BsEq5yC0f4ZUkexnYJ1uV5suDyxYPcGvcSF58b5xoLpr5GP
 Dnz8V6zrobj28j6M+9xPYBwqcPQVoWQzDoCA17Z85bA4btPgpbV5OqMoUZCeEkSOEeFHw5LRO66
 iZl4P2AsnVMKQ5Wjz2JsbQR51yFJ1/LdnOfIuzQV2nOhyLDXqRJd5z28bXxcpQg+r70X2mOQaMq
 4ETh8fnHI/7AkH1GWldBxOrxUGjPfhJqZFSDSB/L2H4ZA6KzJ35yBei6JlRl214JA5Wats/ODq/
 c9YM5yr3Ustj/GUqCLRGVrVR2ss=
X-Received: by 2002:ac8:7f8e:0:b0:519:8a99:2891 with SMTP id
 d75a77b69052e-519a8fe6d17mr62942801cf.41.1781711376686; Wed, 17 Jun 2026
 08:49:36 -0700 (PDT)
MIME-Version: 1.0
From: Francis Michael <francismicheal037@gmail.com>
Date: Wed, 17 Jun 2026 08:49:29 -0700
X-Gm-Features: AVVi8Cd0isg0T_9vK5LMUmr4yzpQuP377CDQQUjilB9FjEbmnZaSfEHQN7H4Rbs
Message-ID: <CAFiVdhGHwrR=RyJ7EyJ+vh9x=5KgmydZK4V+gsh-w8EuUyhdDw@mail.gmail.com>
Subject: Interested in iPXE
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b324dd06547501a8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=francismicheal037@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_IMAGE_ONLY_16=1.092,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_REMOTE_IMAGE=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 11:51:16 -0400
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

--000000000000b324dd06547501a8
Content-Type: text/plain; charset="UTF-8"

Hey QEMU Team,

I came across https://github.com/qemu/ipxe and thought the project was
interesting. I especially liked the focus on network booting and
infrastructure automation, which remains incredibly useful in modern
deployment environments.

I think a project like this could benefit from more visibility,
contributors, forks, stars, and community engagement.

If you're interested in my approach, kindly drop your WhatsApp or Telegram
handle.

francismicheal037@gmail.com

--000000000000b324dd06547501a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><p>Hey QEMU Team,</p><p>I came across <a href=3D"http=
s://github.com/qemu/ipxe">https://github.com/qemu/ipxe</a> and thought the =
project was interesting. I especially liked the focus on network booting an=
d infrastructure automation, which remains incredibly useful in modern depl=
oyment environments.</p><p>I think a project like this could benefit from m=
ore visibility, contributors, forks, stars, and community engagement.</p><p=
>If you&#39;re interested in my approach, kindly drop your WhatsApp or Tele=
gram handle.</p></div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><img width=3D"82" height=3D"96" s=
rc=3D"https://ci3.googleusercontent.com/mail-sig/AIorK4wUJKGHRZnCIbA2IuWrCw=
JWDs594SR-PYmhqccE_oXn33yRVWTHoKZG_1q3lkonhQwXFf75PDeIrYL4"><br><span style=
=3D"color:rgb(31,31,31);font-family:&quot;Google Sans&quot;,Roboto;font-siz=
e:14px;text-align:center;background-color:rgb(233,238,246)"><a href=3D"mail=
to:francismicheal037@gmail.com" target=3D"_blank">francismicheal037@gmail.c=
om</a></span></div></div><img width=3D"0" height=3D"0" class=3D"mailtrack-i=
mg" alt=3D"" style=3D"display:flex" src=3D"https://p.mailmerge.eu/trace/mai=
l/15256c311e2183523673892bc4fb861ab3b77ce3.png?u=3D14137903"></div>

--000000000000b324dd06547501a8--

