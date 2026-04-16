Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BE7F8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQAh-0002aB-1Y; Thu, 16 Apr 2026 13:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.fast2004@gmail.com>)
 id 1wDMkR-000666-D1
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:27:11 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luc.fast2004@gmail.com>)
 id 1wDMkP-0006dC-EL
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 09:27:10 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6501d242e3fso7605193d50.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 06:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776346028; cv=none;
 d=google.com; s=arc-20240605;
 b=ZwyNGW9yApSqkgbeYQo/Ulpeqczsc80balDBh24uIhTd20GkKdqqLaFAl4lnb8CY3O
 LEzjjurTtK8XFMTvQFDNe7+aHV/hq+C3Yn17UmaTERqYgpzW+vwZ+ArDRIOyFs29Z6xe
 +6QVTskSrvvIkFND0JPFW3ZIfbpVH8i4rRRIJw5RO6bSeRmvj/XXMlThH5k9a3bwmi4v
 dzbjFa2Ndh/yN1EJE+sLG+2/PjOAV1EBIlv42ZyTfh9BchOL3LZ/8A/lNSXX0d6Zxtro
 gBvKuD0f/HKd9TKovYbviyqNUSpq+uzt8gv25rTn2Yj9yyQ3UKuBm5cL2JP7iz73MpOd
 DyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=/lKTwosgKuz4jaTb9HsdYAnjyUTznLxk9qfvWLPKFhQ=;
 fh=Z/ChBmagr0Yunxz3rPKeskrqrJshrQ1YmuVp9/a/R7E=;
 b=WzoNzE+tX/j65KbV+SMH5Aim96bPgPc570hsyhMne1hhj95k1aU2I10yqll/0WkWtl
 8NRZh2K4c/YAYOnEPJWVspDIw8OMv/npCZioiWSudhP2EubQhRHgSpwdJ1nvzc4W4pi+
 sfDFkrU2OZ72aJOt9IFSbq5wLgO9fJEBRFiKlx/jU0nb7uaCAghgTmlOBx25nE/uxWJu
 P+Y/YAvyjXEdowEN6tDkSjNfXZFHCVsjMd8REMG2eJ0bMwr80f7V6y+KKzD+0pUYfPLg
 uP5QlkB2re/3HBzfSzQ02NNoN/oPrnGEXBUBQhzk4KLVZIRq/OwBggJhjyOSFD4nMZpi
 9bKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776346028; x=1776950828; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/lKTwosgKuz4jaTb9HsdYAnjyUTznLxk9qfvWLPKFhQ=;
 b=iDivo5pQvdk9vO2uQ46h4T7VolJFOrt+xX0f4MTPTcuBdUSU65SEg795LCHSrVUu9X
 Bj0hPPRUzpbvERMZN0rTUQbMRgtKQtjT2iQq/BX4+a2MAhd8Am3KWAAq86orVmrAVx1p
 D+qRJDJS6konO3OyuvbD+cq+lkYYWaaX50gmInG1x0xlcTz6pbdFVLZYv7+f8m4NHGpk
 og/hjWN53+YxEgRpM+PHMp8lQZGkF/MNkwwzHUR/2neEYePfK4e8U/pj/qV20LCfcWkt
 iIvdD3K8uqEbi51sUlahGaEZ1U564t0edM7wlNYmsXJdeXPjWCwX0Sy8F4g4S+PPo8jI
 fpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776346028; x=1776950828;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/lKTwosgKuz4jaTb9HsdYAnjyUTznLxk9qfvWLPKFhQ=;
 b=rgoADikJbhcoZNkF0TPU98bd/AeGAlF+/kykNCRKMfMGtJaj1ojT1r70fQS38V4BGf
 dNgZbj/RC1ZEFDPDx7Ep92Z+ZwpFOyv4K9AEnCi3a/Q3wnjw+fEkRj0HQczTRvyacZEd
 l5PYgT7Crq14AiLNjzyKnyDkUBMM6Ia+kRZF2LHLrID8i3hdMpGI2ee2HdtLLNkhwMpq
 /Pp/4gCeJT0meKL0eb9mlQsl6Y5UeHGwl3IUfkuCgLvHfMuzLJS7mFEzLgIF556HDw7r
 MqA8HN8Mulg0N8lnO7vqviKprX7oMfnI1lJhzq4Gw9DIwsLGbwb7VQGzx/PAaUPSIJnv
 8C6Q==
X-Gm-Message-State: AOJu0YyBL5aVO9JzyA+JWyqteFQXuy/QlZoZWyiqcpT8teVprC4yTsXv
 U5kD67Ea/cjtup4zmYmfa4ZWKFygBjGDbnWO4GcPgu/wj+8c0esES0o76T93Y/s8QW2g4reNK0J
 FkSeW+3oKHsOni6Ozi/y02UaUBFZhbxaCFmgr
X-Gm-Gg: AeBDievFk2vV3dSKt267w2haCC0Cph77F4CKiYIM3GFKgpXElGHUrj2bR1CnzfKLScq
 R3ZhDFQb4hJAVX9Vt0HwRj/GVkY1R0JpPz1l3+SGaUctPDJm+MyRKPK9ssFr4PrXjG+zNUwclvN
 KLr90V7J57ArIXS/kkAjBvpoRAWbNlKY3HPbDNVDSpOAf7jtnLQ1CvX3QxmUS6YWssoO/ch+dO9
 XqMEOKtv9Rw90DL+A/RE0xqn6XS3yX8er12l+/hQ2qBdeYf4cUsqoLZXSau60EebhFD8nfgIJXR
 gJYVn5ElXziYWBw+QAWL1VA6J9ox3yi4K/jggsu8
X-Received: by 2002:a53:b546:0:b0:651:9538:1905 with SMTP id
 956f58d0204a3-65198ab48d5mr16436977d50.27.1776346027483; Thu, 16 Apr 2026
 06:27:07 -0700 (PDT)
MIME-Version: 1.0
From: Lucas Cardoso <luc.fast2004@gmail.com>
Date: Thu, 16 Apr 2026 10:26:56 -0300
X-Gm-Features: AQROBzBrcDtd1NOYZUREKLlO3m_d_TxNvtj0R3o9prw8bBgshxq55Q1WDxcR4Q8
Message-ID: <CAHMzB=iZB24QqPwcMjJrfp4GjCkKKpa_0aG0Qx=YOFGUxab8Lg@mail.gmail.com>
Subject: First-time contributor looking to work on malloc/calloc cleanups
To: qemu-devel@nongnu.org
Cc: "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f764dd064f93c95d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=luc.fast2004@gmail.com; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 13:06:30 -0400
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

--000000000000f764dd064f93c95d
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I am looking to make my first contribution to QEMU and would like to start
by tackling the remaining cleanups for the GitLab issue: "conversions of
malloc/calloc/free to g_malloc/g_new/g_free etc" (
https://gitlab.com/qemu-project/qemu/-/work_items/1798).

I've checked the codebase and saw that some files mentioned in the original
issue still have remaining malloc calls that need converting:
- hw/audio/fmopl.c
- target/xtensa/translate.c
- disas/m68k.c
- disas/sparc.c
Also, this file still has a calloc call that needs converting:
- hw/xtensa/mx_pic.c

I checked the mailing list archive, and saw that someone else tried to
tackle this issue a month ago. They made some progress on hw/audio/fmopl.c,
but it seems as if they've stopped working on it.
I would like to start working on these one file at a time, starting with
hw/audio/fmopl.c for malloc conversions and hw/xtensa/mx_pic.c for calloc.

Following the 'Contribute/BiteSizedTasks' wiki page, I decided to send this
email. Could you let me know if anyone is currently working on these
specific files, or if it's safe for me to proceed? If so, I'd appreciate it
if someone could assign the corresponding GitLab issue to me.

Thanks,
Lucas Cardoso
@lucasac00 on Gitlab

--000000000000f764dd064f93c95d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi everyone,<br><br>I am looking to make my first con=
tribution to QEMU and would like to start by tackling the remaining cleanup=
s for the GitLab issue: &quot;conversions of malloc/calloc/free to g_malloc=
/g_new/g_free etc&quot; (<a href=3D"https://gitlab.com/qemu-project/qemu/-/=
work_items/1798">https://gitlab.com/qemu-project/qemu/-/work_items/1798</a>=
).<br><br>I&#39;ve checked the codebase and saw that some files mentioned i=
n the original issue still have remaining malloc calls that need converting=
:<br>- hw/audio/fmopl.c<br>- target/xtensa/translate.c<br>- disas/m68k.c<br=
>- disas/sparc.c<br>Also, this file still has a calloc call that needs conv=
erting:<br>- hw/xtensa/mx_pic.c<br><br>I checked the mailing list archive, =
and saw that someone else tried to tackle this issue a month ago. They made=
 some progress on hw/audio/fmopl.c, but it seems as if they&#39;ve stopped =
working on it.<br>I would like to start working on these one file at a time=
, starting with hw/audio/fmopl.c for malloc conversions and hw/xtensa/mx_pi=
c.c for calloc. <br><br>Following the &#39;Contribute/BiteSizedTasks&#39; w=
iki page, I decided to send this email. Could you let me know if anyone is =
currently working on these specific files, or if it&#39;s safe for me to pr=
oceed? If so, I&#39;d appreciate it if someone could assign the correspondi=
ng GitLab issue to me.<br><br>Thanks,<br>Lucas Cardoso<br></div>@lucasac00 =
on Gitlab</div>

--000000000000f764dd064f93c95d--

