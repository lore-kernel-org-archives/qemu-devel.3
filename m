Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF87EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 21:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXSfl-0004uo-Ol; Fri, 26 Jul 2024 17:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slyubski@gmail.com>)
 id 1sXQpE-0001DP-Mi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 15:42:00 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <slyubski@gmail.com>)
 id 1sXQpD-0005Jo-3F
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 15:42:00 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e01a6e5da1fso6103276.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 12:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722022917; x=1722627717; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RhSLrCAtx/+SYpHvn38v0ZBPbN69iFcyYxP1ZILqzY8=;
 b=aacVHRr6CF9MZl3NoiQy05Zwj7ObZ3HlcNHOMFswFgPS5elK+4w/+b2jC3oBa3drQj
 G/XHZIPS1giR1czQU5una15wA1NnPSBI8nzkF93wvZscVrCfttyfSj6mSsUgM0WX0Gh+
 nMo083IGy7FD+JFaNRZJrY7RneRIB+4UmCKgEqg5hDmHUsLOUeSHub8rjYBpk5uqZ2kC
 240bEfoQOSI040DdIvV66jGVPJ+TPTuvjN4PbaRks04Gv92YyNBLsd7SVSQutpmpeFw6
 cac2l/v5K4uXfEYIPkumFQy3QBb2ixlnS9obF4M4QSSw8/LtaH0VviotJCONMtjMfVwQ
 pzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722022917; x=1722627717;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RhSLrCAtx/+SYpHvn38v0ZBPbN69iFcyYxP1ZILqzY8=;
 b=FN3PraatOqzUGlg6kJhLO7KgT9yZJGZVc1mOmjeDEoCube7PWIEKYSrapzl3uSPUW8
 lbdfvan+pj1XtOyzK3sKdsAeXuUkvKAkFWAp34cTmhwEJvnTL2sDYaC4HNYs1Z2rMC4C
 7OA58tGYWvKHAW4k99ILD7FCDcGZj0K7HtN29SVMV+yCxD8nHGKNjjGZMlDiIFzvs2f0
 mvhqDcULbx/6nefUYyTAwYvQ6gYPMn1YN2V7fv5PMzWajsh93cKd/X+XZbstDfoCCfqN
 v5xeTDTRZ/iDDGqa/bsNynO5g9TmLoxRDgkPKL3FvTxzKOz8lYEpUGbBJCJ+/yeug1zg
 Fcgg==
X-Gm-Message-State: AOJu0Yx+rHmPJ6yk5/3aElKAbTasrRR5Kuto3t0qcswVfO3xRBkmVrG0
 oCOycFl3OI+qJjci22GqfXq1lbOrXZf+pQGZ6oGDprM2HMbU8TWETSG0CHswk/8L9IsR0XKcTZ5
 V5XWHeF0fEcadm7CNu7IjjezpeY5mBMUo
X-Google-Smtp-Source: AGHT+IFBVrwWTQi6Wxk4GINoQvypNQHzNAR3EO9ugvTumES/mp52x2g3Azuw8pIiLJyBaCPzhWey7BN21+gpIqDgQMg=
X-Received: by 2002:a81:4318:0:b0:65e:684a:2d95 with SMTP id
 00721157ae682-6752313f950mr33945217b3.7.1722022917247; Fri, 26 Jul 2024
 12:41:57 -0700 (PDT)
MIME-Version: 1.0
From: Sergei Lyubski <slyubski@gmail.com>
Date: Fri, 26 Jul 2024 12:41:47 -0700
Message-ID: <CAMLUMH6dRAg+s9jzfVg3ihbE42yO1PssYLnKm-o99aEkpD8QyQ@mail.gmail.com>
Subject: The question about migration/checkpointing
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000047204b061e2bb454"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=slyubski@gmail.com; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 26 Jul 2024 17:40:11 -0400
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

--00000000000047204b061e2bb454
Content-Type: text/plain; charset="UTF-8"

  Hi guys,

My name is Sergey. My company uses QEMU for  CPU
performance simulation/evaluaton.
Sorry, I found  your emails in QEMU  relatively recent commits  into ram.c
.  Why ram.c . Because I see some weirdness in the  behavior.

Our goal is :
     a)  To boot  Linux , to launch some  TEST/SPEC, to drop a few
checkpoints.
     b)  To resume  execution from  those checkpoints, to attach a
performance simulator and
           to evaluate performance at the "hot" code  areas.

  How we tried to do it .

     a) run QEMU with -monitor telnet options
     b) connect  to QEMU with telnet
     c)  after  LINUX  booted  in  QEMU monitor (telnet)  executed
            migrate -d file://<FULL  CKPT PATH>
            quit
      d)  run QEMU  with option -incoming file://<FULL CKPT PATH>

  Now !!

  If  I  drop the checkpoint  when running  on linux a long ( endless) test
which  prints on      the console,  everything works (!)  and  the console
is properly restored.

  When I drop  the checkpoint  when the linux console is in shell  prompt,
the restoration does  not  work.
   I see either error message  from  ram_load_precopy()
       error_report("Unknown combination of migration flags: 0x%x", flags);

       or

   the console is locked, QEMU restarts and  runs  (ps, top).   The only
solution is to kill
   QEMU .  After that,  QEMU console is distorted and requires to type
RESET.

    Could you please comment on the above issues.
    If you need more info I can send you my screen shots.
    Please note that  that the similar behavior is observed on  both
     qemu 9.0  ( stable-9.0)  and
     qemu 8.x

Thanks in advance.
Sergey Lyubskiy

--00000000000047204b061e2bb454
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0 Hi guys,<div><br></div><div>My name is Sergey. My c=
ompany uses QEMU for=C2=A0 CPU performance=C2=A0simulation/evaluaton.</div>=
<div>Sorry, I found=C2=A0 your emails in QEMU=C2=A0 relatively=C2=A0recent =
commits=C2=A0 into ram.c .=C2=A0 Why ram.c . Because I see some weirdness i=
n the=C2=A0 behavior.</div><div>=C2=A0=C2=A0</div><div>Our goal is :</div><=
div>=C2=A0 =C2=A0 =C2=A0a)=C2=A0 To boot=C2=A0 Linux , to launch some=C2=A0=
 TEST/SPEC, to drop a few checkpoints.</div><div>=C2=A0 =C2=A0 =C2=A0b)=C2=
=A0 To resume=C2=A0 execution from=C2=A0 those checkpoints, to attach a per=
formance simulator and</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0t=
o evaluate=C2=A0performance at the &quot;hot&quot; code=C2=A0 areas.</div><=
div><br></div><div>=C2=A0 How we tried to do it .</div><div><br></div><div>=
=C2=A0 =C2=A0 =C2=A0a) run QEMU with -monitor telnet options</div><div>=C2=
=A0 =C2=A0 =C2=A0b) connect=C2=A0 to QEMU with telnet=C2=A0</div><div>=C2=
=A0 =C2=A0 =C2=A0c)=C2=A0 after=C2=A0 LINUX=C2=A0 booted=C2=A0 in=C2=A0 QEM=
U monitor (telnet)=C2=A0 executed</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 migrate -d file://&lt;FULL=C2=A0 CKPT PATH&gt;=C2=A0</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 quit</div><div>=C2=A0 =C2=A0 =C2=
=A0 d)=C2=A0 run QEMU=C2=A0 with option=C2=A0-incoming file://&lt;FULL CKPT=
 PATH&gt;</div><div><br></div><div>=C2=A0 Now !!</div><div><br></div><div>=
=C2=A0 If=C2=A0 I=C2=A0 drop the checkpoint=C2=A0 when running=C2=A0 on lin=
ux a long ( endless) test which=C2=A0 prints on=C2=A0 =C2=A0 =C2=A0 the con=
sole,=C2=A0 everything works (!)=C2=A0 and=C2=A0 the console is properly re=
stored.</div><div>=C2=A0 =C2=A0</div><div>=C2=A0 When I drop=C2=A0 the chec=
kpoint=C2=A0 when the linux console is in shell=C2=A0 prompt, the restorati=
on does=C2=A0 not=C2=A0 work.</div><div>=C2=A0 =C2=A0I see either error mes=
sage=C2=A0 from=C2=A0 ram_load_precopy()</div><div>=C2=A0 =C2=A0 =C2=A0=C2=
=A0=C2=A0error_report(&quot;Unknown combination of migration flags: 0x%x&qu=
ot;, flags);</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0or</div><d=
iv><br></div><div>=C2=A0 =C2=A0the console is locked, QEMU restarts and=C2=
=A0 runs=C2=A0 (ps, top).=C2=A0 =C2=A0The only=C2=A0 solution is to kill=C2=
=A0</div><div>=C2=A0 =C2=A0QEMU .=C2=A0 After that,=C2=A0=C2=A0QEMU console=
 is distorted and requires to type RESET.</div><div><br></div><div>=C2=A0 =
=C2=A0 Could you please comment on the above issues.=C2=A0</div><div>=C2=A0=
 =C2=A0 If you need more info I can send you my screen shots.</div><div>=C2=
=A0 =C2=A0 Please note that=C2=A0 that the similar behavior is observed on=
=C2=A0 both</div><div>=C2=A0 =C2=A0 =C2=A0qemu 9.0=C2=A0 ( stable-9.0)=C2=
=A0 and</div><div>=C2=A0 =C2=A0 =C2=A0qemu 8.x</div><div><br></div><div>Tha=
nks in advance.</div><div>Sergey Lyubskiy</div><div class=3D"gmail-yj6qo"><=
/div><div class=3D"gmail-adL"><br></div></div>

--00000000000047204b061e2bb454--

