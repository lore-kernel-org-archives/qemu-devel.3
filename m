Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD37BC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 03:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwZI3-0007bI-KU; Mon, 15 Apr 2024 23:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jchan@ventanamicro.com>)
 id 1rwZI2-0007Zu-12
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 23:15:22 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jchan@ventanamicro.com>)
 id 1rwZHz-0007VS-Oj
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 23:15:21 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-617cd7bd929so45208677b3.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 20:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713237318; x=1713842118; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+nSGaMg//toxJD22pXFrX1xGuh8XqJLGmeeuNQ4rios=;
 b=o4rL8LqX8410sFikpA6P5dQcuQHo9MqVz9B2zF3N6UsRDTOYp8K24P8ElbXg0VlpA4
 WszT2sm/HPfOMdHQuTmPjaiem7KPy0BN5qv6HjUYPbtgIaOsHfMz75QlKio+fZiN7TBO
 rGqLA8QZggpk7CyPcvDoAf/hnizQySTOryOVKzSv5Xdvi+5y/Oi7RJ7a7veO6IuF8a0v
 I5wrLxaiAyQym1UrLRnu0YIZ/UZ2IocTYRjVC5aDKFBIDDDWWXdwQEi/USsN2HWY/IYM
 Z2Bn8CuciK9mLmGUcpyOBt0jyldlA7yeFEFbLvdTiRwcH46ESTC99qC34QxKA9QLXcx8
 E9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713237318; x=1713842118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+nSGaMg//toxJD22pXFrX1xGuh8XqJLGmeeuNQ4rios=;
 b=ad1BTE6g2Vat4HmlQgom0iAcr1PVSMOq9BcbHCokbMY+EpGBOFObi77DNdbFoj6c8n
 qOWLK3jL+6VRFAPWSN1DmS88DlF1v8p1WxFJu69Fu8wqE4H8WdjsKduf3c+5EXKMCXCv
 BpBibwWVmxK0q4h7y2FYuLB8gL2oDzI5yzak5+Ii8h3Q9Y0dqk6sG1sI1O6JuRVug6sV
 JbXvulr6I8STt2ia0waXGy1nIYVfJe1osBTKg8vg82EXdwyDVsFmZ0S+1YTXpfXuwhbR
 9V0IRD8Oq5lteE0aqyWnPCZ36BX4cRyNplEYuZixEDLoWzdH3qpZw72NRRFmF2b9xnEg
 KZYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYrFq8sgUimlXNImnbNvf8wtOX9L4lh6T5b0MPppjRZhy/5Hi6y2hseiUXJNVFUiqgnykwpz1G+HlCdK3Mp5HTWdgTct4=
X-Gm-Message-State: AOJu0Yyo+ZeXoQQliHhpZecWekPz7ttWWXGCTZHKse+jdXCtVSWoFw6D
 vIqWe9ItzRn0GRocl1jjfhmayMzfZ/rvHh2ULk3WIRajAmBk+FlnPKKfRkmsTA4T5fq5s9Mg8Ut
 zoJKQRb2UYrdTk1Uk0HbguTUbx8XIjZ/gKRAgKQ==
X-Google-Smtp-Source: AGHT+IGrRH3NqQWZSFQyomPxpdHpU+OjqSL3H5I8khvSkiOw6+WBO/a6hV6j6XxKItkzV38urxUTPMNeUVqyGWfpoug=
X-Received: by 2002:a0d:d596:0:b0:618:36de:a3dc with SMTP id
 x144-20020a0dd596000000b0061836dea3dcmr11890430ywd.28.1713237318238; Mon, 15
 Apr 2024 20:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240413105929.7030-1-alexei.filippov@syntacore.com>
 <CA+OBw2tScc2Gt+eHy3onTnK8m7XDfjbMVZ7dBoFowq1kL8c7EA@mail.gmail.com>
In-Reply-To: <CA+OBw2tScc2Gt+eHy3onTnK8m7XDfjbMVZ7dBoFowq1kL8c7EA@mail.gmail.com>
From: Joseph Chan <jchan@ventanamicro.com>
Date: Mon, 15 Apr 2024 20:14:40 -0700
Message-ID: <CA+OBw2t9RRk4q+xntusYSS+yE=R1S3XR3qzM2_jhXBazrZs3ZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
To: Alexei Filippov <alexei.filippov@syntacore.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c520d306162e2567"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=jchan@ventanamicro.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c520d306162e2567
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Digging more in  Priv-v1.12/riscv-privileged-20211203.pdf
<https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/ris=
cv-privileged-20211203.pdf>
 :
Page 82,  Section 4.3.2 Virtual Address Translation Process.

The spec actually mentions an address translation algorithm. Step 2
mentions the exception code should be " access-fault exception
corresponding to the original access type". i.e. 1, 5, 7.  All other steps
should use " page-fault exception corresponding to the original access
type". i.e. 12, 13, 15.

Regards,
Joseph Chan

On Mon, Apr 15, 2024 at 11:50=E2=80=AFAM Joseph Chan <jchan@ventanamicro.co=
m> wrote:

> FYI
>
> Priv-v1.12/riscv-privileged-20211203.pdf
> <https://github.com/riscv/riscv-isa-manual/releases/download/Priv-v1.12/r=
iscv-privileged-20211203.pdf>
> defines exception priorities on
> Page 40, Table 3.7
> Page 130, Table 8.7
>
> There is a sentence under Table 3.7:
> "When a virtual address is translated into a physical address, the addres=
s
> translation algorithm
> determines what specific exception may be raised."
>
>
> The spec does not insist any implementation to report Exception Code 12
> over 1; 13,15 over 5, 7. On the other hand, the phrases "During instructi=
on
> address translation:" and "With physical address for instruction:" gives =
me
> the impression that when the implementation can distinguish between these
> situations, then reporting 12 , 13, 15 instead of 1, 5, 7 will provide a
> fine-grained reason for why things were broken.
>
> Regards,
> Joseph Chan
>
>
> On Sat, Apr 13, 2024 at 3:59=E2=80=AFAM Alexei Filippov <
> alexei.filippov@syntacore.com> wrote:
>
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> raise_mmu_exception(), as is today, is prioritizing guest page faults by
>> checking first if virt_enabled && !first_stage, and then considering the
>> regular inst/load/store faults.
>>
>> There's no mention in the spec about guest page fault being a higher
>> priority that PMP faults. In fact, privileged spec section 3.7.1 says:
>>
>> "Attempting to fetch an instruction from a PMP region that does not have
>> execute permissions raises an instruction access-fault exception.
>> Attempting to execute a load or load-reserved instruction which accesses
>> a physical address within a PMP region without read permissions raises a
>> load access-fault exception. Attempting to execute a store,
>> store-conditional, or AMO instruction which accesses a physical address
>> within a PMP region without write permissions raises a store
>> access-fault exception."
>>
>> So, in fact, we're doing it wrong - PMP faults should always be thrown,
>> regardless of also being a first or second stage fault.
>>
>> The way riscv_cpu_tlb_fill() and get_physical_address() work is
>> adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
>> reflected in the 'pmp_violation' flag. What we need is to change
>> raise_mmu_exception() to prioritize it.
>>
>> Reported-by: Joseph Chan <jchan@ventanamicro.com>
>> Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU
>> translation stage")
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>  target/riscv/cpu_helper.c | 22 ++++++++++++----------
>>  1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index bc70ab5abc..196166f8dd 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1203,28 +1203,30 @@ static void raise_mmu_exception(CPURISCVState
>> *env, target_ulong address,
>>
>>      switch (access_type) {
>>      case MMU_INST_FETCH:
>> -        if (env->virt_enabled && !first_stage) {
>> +        if (pmp_violation) {
>> +            cs->exception_index =3D RISCV_EXCP_INST_ACCESS_FAULT;
>> +        } else if (env->virt_enabled && !first_stage) {
>>              cs->exception_index =3D RISCV_EXCP_INST_GUEST_PAGE_FAULT;
>>          } else {
>> -            cs->exception_index =3D pmp_violation ?
>> -                RISCV_EXCP_INST_ACCESS_FAULT :
>> RISCV_EXCP_INST_PAGE_FAULT;
>> +            cs->exception_index =3D RISCV_EXCP_INST_PAGE_FAULT;
>>          }
>>          break;
>>      case MMU_DATA_LOAD:
>> -        if (two_stage && !first_stage) {
>> +        if (pmp_violation) {
>> +            cs->exception_index =3D RISCV_EXCP_LOAD_ACCESS_FAULT;
>> +        } else if (two_stage && !first_stage) {
>>              cs->exception_index =3D RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
>>          } else {
>> -            cs->exception_index =3D pmp_violation ?
>> -                RISCV_EXCP_LOAD_ACCESS_FAULT :
>> RISCV_EXCP_LOAD_PAGE_FAULT;
>> +            cs->exception_index =3D RISCV_EXCP_LOAD_PAGE_FAULT;
>>          }
>>          break;
>>      case MMU_DATA_STORE:
>> -        if (two_stage && !first_stage) {
>> +        if (pmp_violation) {
>> +            cs->exception_index =3D RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
>> +        } else if (two_stage && !first_stage) {
>>              cs->exception_index =3D
>> RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
>>          } else {
>> -            cs->exception_index =3D pmp_violation ?
>> -                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
>> -                RISCV_EXCP_STORE_PAGE_FAULT;
>> +            cs->exception_index =3D RISCV_EXCP_STORE_PAGE_FAULT;
>>          }
>>          break;
>>      default:
>> --
>> 2.34.1
>>
>>

--000000000000c520d306162e2567
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Digging more in=C2=A0

<a href=3D"https://github.com/riscv/riscv-isa-manual/releases/download/Priv=
-v1.12/riscv-privileged-20211203.pdf" target=3D"_blank">Priv-v1.12/riscv-pr=
ivileged-20211203.pdf</a>=C2=A0:<br>Page 82,=C2=A0 Section 4.3.2 Virtual Ad=
dress Translation Process.<div><br></div><div>The spec actually=C2=A0mentio=
ns an address translation algorithm. Step 2 mentions the exception code sho=
uld be &quot;

 access-fault exception corresponding
to the original access type&quot;. i.e. 1, 5, 7.=C2=A0 All other steps shou=
ld use &quot;

page-fault exception corresponding
to the original access type&quot;. i.e. 12, 13, 15.</div><div><br></div><di=
v>Regards,</div><div>Joseph Chan</div></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 15, 2024 at 11:50=E2=80=
=AFAM Joseph Chan &lt;<a href=3D"mailto:jchan@ventanamicro.com">jchan@venta=
namicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">FYI<div><br><a href=3D"https://github.com/riscv=
/riscv-isa-manual/releases/download/Priv-v1.12/riscv-privileged-20211203.pd=
f" target=3D"_blank">Priv-v1.12/riscv-privileged-20211203.pdf</a>=C2=A0 def=
ines exception priorities on<br>Page 40, Table 3.7<br>Page 130, Table 8.7<b=
r><br>There is a sentence under Table 3.7:</div><div>&quot;When a virtual a=
ddress is translated into a physical address, the address translation algor=
ithm<br>determines what specific exception may be raised.&quot;</div><div><=
br><br>The spec does not insist any<b> </b>implementation to report Excepti=
on Code 12 over 1; 13,15 over 5, 7. On the other hand, the phrases &quot;Du=
ring instruction address translation:&quot; and &quot;With physical address=
 for instruction:&quot; gives me the impression that when the implementatio=
n can distinguish between these situations, then reporting 12 , 13, 15 inst=
ead of 1, 5, 7 will provide a fine-grained reason for why things were broke=
n.</div><div><br></div><div>Regards,</div><div>Joseph Chan<br><br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Sat, Apr 13, 2024 at 3:59=E2=80=AFAM Alexei Filippov &lt;<a href=3D"mailto:=
alexei.filippov@syntacore.com" target=3D"_blank">alexei.filippov@syntacore.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@ventanamicr=
o.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
<br>
raise_mmu_exception(), as is today, is prioritizing guest page faults by<br=
>
checking first if virt_enabled &amp;&amp; !first_stage, and then considerin=
g the<br>
regular inst/load/store faults.<br>
<br>
There&#39;s no mention in the spec about guest page fault being a higher<br=
>
priority that PMP faults. In fact, privileged spec section 3.7.1 says:<br>
<br>
&quot;Attempting to fetch an instruction from a PMP region that does not ha=
ve<br>
execute permissions raises an instruction access-fault exception.<br>
Attempting to execute a load or load-reserved instruction which accesses<br=
>
a physical address within a PMP region without read permissions raises a<br=
>
load access-fault exception. Attempting to execute a store,<br>
store-conditional, or AMO instruction which accesses a physical address<br>
within a PMP region without write permissions raises a store<br>
access-fault exception.&quot;<br>
<br>
So, in fact, we&#39;re doing it wrong - PMP faults should always be thrown,=
<br>
regardless of also being a first or second stage fault.<br>
<br>
The way riscv_cpu_tlb_fill() and get_physical_address() work is<br>
adequate: a TRANSLATE_PMP_FAIL error is immediately reported and<br>
reflected in the &#39;pmp_violation&#39; flag. What we need is to change<br=
>
raise_mmu_exception() to prioritize it.<br>
<br>
Reported-by: Joseph Chan &lt;<a href=3D"mailto:jchan@ventanamicro.com" targ=
et=3D"_blank">jchan@ventanamicro.com</a>&gt;<br>
Fixes: 82d53adfbb (&quot;target/riscv/cpu_helper.c: Invalid exception on MM=
U translation stage&quot;)<br>
Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:dbarboza@venta=
namicro.com" target=3D"_blank">dbarboza@ventanamicro.com</a>&gt;<br>
---<br>
=C2=A0target/riscv/cpu_helper.c | 22 ++++++++++++----------<br>
=C2=A01 file changed, 12 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c<br>
index bc70ab5abc..196166f8dd 100644<br>
--- a/target/riscv/cpu_helper.c<br>
+++ b/target/riscv/cpu_helper.c<br>
@@ -1203,28 +1203,30 @@ static void raise_mmu_exception(CPURISCVState *env,=
 target_ulong address,<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (access_type) {<br>
=C2=A0 =C2=A0 =C2=A0case MMU_INST_FETCH:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (env-&gt;virt_enabled &amp;&amp; !first_sta=
ge) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_violation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_INST_ACCESS_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (env-&gt;virt_enabled &amp;&amp; !fi=
rst_stage) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D =
RISCV_EXCP_INST_GUEST_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D pmp_v=
iolation ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_INST_AC=
CESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_INST_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MMU_DATA_LOAD:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (two_stage &amp;&amp; !first_stage) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_violation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_LOAD_ACCESS_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (two_stage &amp;&amp; !first_stage) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D =
RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D pmp_v=
iolation ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_LOAD_AC=
CESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_LOAD_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MMU_DATA_STORE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (two_stage &amp;&amp; !first_stage) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pmp_violation) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_STORE_AMO_ACCESS_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (two_stage &amp;&amp; !first_stage) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cs-&gt;exception_index =3D =
RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D pmp_v=
iolation ?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_STORE_A=
MO_ACCESS_FAULT :<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_EXCP_STORE_P=
AGE_FAULT;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D RISCV=
_EXCP_STORE_PAGE_FAULT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000c520d306162e2567--

