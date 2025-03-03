Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A011FC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8r3-0001lH-RV; Mon, 03 Mar 2025 11:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1tp8qU-0001fG-Gu
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:41:00 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1tp8qO-00010Y-Iv
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:40:42 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2bd2218ba4fso1231467fac.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741020038; x=1741624838; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+3OypkSyzT2PdHTpeVbM1xfI1GBgSPTl2hSdyNzg6hk=;
 b=bLz+6LclnAvX4EkF/jUOuqkEXzsxpH/TxvFLY7hiP+u+kAzGR/ChWKOxA1jL+W5+Hy
 gcpV17szBbbxaRs7bBzKoCk8i9T46cZZyl/on5j0ttpnFsSCVsWISojEOcj9zH0bYmzr
 b4LkCvTp5IrQ80qKadCivh1dMoNzo4pCFrOz7ANCiliuPQ4v8Mj/UrQLARbejjSnDvj5
 a+JBLvcZQ7ydnWev0bXaI9yjVK8gZ9quJayC8g6K5eGS9MhghbxEpBp3nlK66ufd0Kid
 rvMMedMGpzkFvJ/9OmxIEXaD+7XU+c7bc7WP5FGDbvWCbt0oGk5szOREkuVO0UTRMhZv
 ii6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741020038; x=1741624838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+3OypkSyzT2PdHTpeVbM1xfI1GBgSPTl2hSdyNzg6hk=;
 b=oJVtI7dh2mhtayvQLCKFPiW1nxpHFHI80mJTlipFRyOjMEJFUKHzDDgDvhhVbRzI4h
 0c2qusMN36mm0AEN2U52LNY40UmEq/JQqwIkMDIaX+w6d1uQBr9h7F+/comA6s+sBHVl
 u7R+ruNcCikU5tibhZuWSTfBFh0b7cGq/906pkqNqlVU4Qt1ahb+XuBEN8i42567SwKu
 hL7yujxi4EjnLt8dSEHALZIFnE8Mjjk0xI/YrSUrESL6ORqg53KIQpPeoYfRSTaB43nw
 rdGTcBry3kqixLz07yeU6Jc4zR+9X0Jw6Pr9qjRg5ZHtORN95xc//fgMcNuIXCr9LwPV
 2KrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8umrGD3S0i2ymuonhXCw8T6Ra7y3As+Wt9prEL5lCGHCaL5sXr53tfWUU44lJSjweRHTLHa7ow12x@nongnu.org
X-Gm-Message-State: AOJu0YzbD9H+a/vU6qMTWvuevX/pS3tfVeifEfU+dr7P3aLmxePImqXz
 U7xuxtfWY9CereqquVdaQ8kBGohm2PcELBp1R65H7W3s85bMqP8FofCvLicbCsbcDkOFYXgMXOT
 qeGzkEkhWVvK15xMXYuj8YNthebPsA+CG1YBXQIyxsKiHuvuEF9eY
X-Gm-Gg: ASbGncs9oRhEU6vR3hbYjlrqiAa8LcEK1HfIOSacngAN1CgQ5XlxfxjSjk+O0+7WOBV
 x0NA06LhgysOu1SRLC/aKWVG6HNxdrWlX52Q4rcAMYHii0mEAu97oOK0n5nlpXpGU+Kd5bNNv+3
 hIgrrMm+8HxL5iQxTyL+CGMLCZorvmWIwmt8oeVsv2gpGQ+0FgUq6lqes=
X-Google-Smtp-Source: AGHT+IGm3z8mtRn+h+4P1cNExypezaTBVZqeg0XqnJAbGZoXk6sfOeguZHyS90lz9LfSHU4wPy4h7i4GA9c0cFAvZzE=
X-Received: by 2002:a05:6870:8199:b0:2c1:5b95:5f1b with SMTP id
 586e51a60fabf-2c17844e046mr7958915fac.23.1741020037661; Mon, 03 Mar 2025
 08:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20250228212329.1775669-1-venture@google.com>
 <7771abbe-ab3f-43d8-9ac6-9ea0bc63b243@linaro.org>
 <CAO=notwzQsC7oJZxY_Jby9znX0ov62AVXsTENb7tagEBR2DcWQ@mail.gmail.com>
 <CAAAKUPP_mK2VApyCOf2N3twYfn_fe5P5Y_OMhmCSqP1HrhZSDQ@mail.gmail.com>
In-Reply-To: <CAAAKUPP_mK2VApyCOf2N3twYfn_fe5P5Y_OMhmCSqP1HrhZSDQ@mail.gmail.com>
From: Peter Foley <pefoley@google.com>
Date: Mon, 3 Mar 2025 11:40:26 -0500
X-Gm-Features: AQ5f1JqxIHIC4FwFm2yZjFviNk_TAqybaln3odiChGApNURb-mgPdmQKCBEDfiA
Message-ID: <CAAAKUPN2AJAuNuzoHn5dOf3R3WY0VZzmT3mff0ATZF2-6SHsqQ@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: fix msan findings in translate-all
To: Patrick Venture <venture@google.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e4d34b062f72d088"
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=pefoley@google.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000e4d34b062f72d088
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And interestingly enough, it appears that execution continues even with
early return from get_page_addr_code_hostp:
https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/translate-all.=
c?ref_type=3Dheads#L308

Which implies that we could still have an uninitialized value here:
https://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/translate-all.=
c?ref_type=3Dheads#L362

On Mon, Mar 3, 2025 at 11:34=E2=80=AFAM Peter Foley <pefoley@google.com> wr=
ote:

> For reference, the full output from msan looks like:
>
> =3D=3D4872=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0xaaaac681ef98 in tb_gen_code third_party/qemu/accel/tcg/translate=
-all.c:358:21
>     #1 0xaaaac67f2520 in cpu_exec_loop third_party/qemu/accel/tcg/cpu-exe=
c.c:993:22
>     #2 0xaaaac67f154c in cpu_exec_setjmp third_party/qemu/accel/tcg/cpu-e=
xec.c:1039:12
>     #3 0xaaaac67f1240 in cpu_exec third_party/qemu/accel/tcg/cpu-exec.c:1=
065:11
>     #4 0xaaaac681022c in tcg_cpu_exec third_party/qemu/accel/tcg/tcg-acce=
l-ops.c:79:11
>     #5 0xaaaac680ede4 in mttcg_cpu_thread_fn third_party/qemu/accel/tcg/t=
cg-accel-ops-mttcg.c:95:17
>     #6 0xaaaacf096698 in qemu_thread_start third_party/qemu/util/qemu-thr=
ead-posix.c:541:9
>     #7 0xffffa9242cec in start_thread (/usr/grte/v5/lib64/libpthread.so.0=
+0xbcec) (BuildId: 0bdac2117d4465a78d3de57b307368b4)
>     #8 0xffffa912ec98 in thread_start (/usr/grte/v5/lib64/libc.so.6+0x116=
c98) (BuildId: 613d20d3b812b4c87fe9ebf8c4caae83)
>
>   Uninitialized value was stored to memory at
>     #0 0xaaaac681ef94 in tb_gen_code third_party/qemu/accel/tcg/translate=
-all.c:358:50
>     #1 0xaaaac67f2520 in cpu_exec_loop third_party/qemu/accel/tcg/cpu-exe=
c.c:993:22
>     #2 0xaaaac67f154c in cpu_exec_setjmp third_party/qemu/accel/tcg/cpu-e=
xec.c:1039:12
>     #3 0xaaaac67f1240 in cpu_exec third_party/qemu/accel/tcg/cpu-exec.c:1=
065:11
>     #4 0xaaaac681022c in tcg_cpu_exec third_party/qemu/accel/tcg/tcg-acce=
l-ops.c:79:11
>     #5 0xaaaac680ede4 in mttcg_cpu_thread_fn third_party/qemu/accel/tcg/t=
cg-accel-ops-mttcg.c:95:17
>     #6 0xaaaacf096698 in qemu_thread_start third_party/qemu/util/qemu-thr=
ead-posix.c:541:9
>     #7 0xffffa9242cec in start_thread (/usr/grte/v5/lib64/libpthread.so.0=
+0xbcec) (BuildId: 0bdac2117d4465a78d3de57b307368b4)
>     #8 0xffffa912ec98 in thread_start (/usr/grte/v5/lib64/libc.so.6+0x116=
c98) (BuildId: 613d20d3b812b4c87fe9ebf8c4caae83)
>
>   Uninitialized value was created by an allocation of 'host_pc' in the st=
ack frame
>     #0 0xaaaac681d8ac in tb_gen_code third_party/qemu/accel/tcg/translate=
-all.c:297:5
>
> SUMMARY: MemorySanitizer: use-of-uninitialized-value third_party/qemu/acc=
el/tcg/translate-all.c:358:21 in tb_gen_code
> Exiting
>
>
> On Fri, Feb 28, 2025 at 5:26=E2=80=AFPM Patrick Venture <venture@google.c=
om>
> wrote:
>
>>
>>
>> On Fri, Feb 28, 2025 at 1:38=E2=80=AFPM Richard Henderson <
>> richard.henderson@linaro.org> wrote:
>>
>>> On 2/28/25 13:23, Patrick Venture wrote:
>>> > From: Peter Foley <pefoley@google.com>
>>> >
>>> > e.g.
>>> >    Uninitialized value was created by an allocation of 'host_pc' in
>>> the stack frame
>>> >    #0 0xaaaac07df87c in tb_gen_code
>>> third_party/qemu/accel/tcg/translate-all.c:297:5
>>> >
>>> > Signed-off-by: Peter Foley <pefoley@google.com>
>>> > Signed-off-by: Patrick Venture <venture@google.com>
>>> > ---
>>> >   accel/tcg/translate-all.c | 2 +-
>>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>>> >
>>> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>>> > index d4189c7386..f584055a15 100644
>>> > --- a/accel/tcg/translate-all.c
>>> > +++ b/accel/tcg/translate-all.c
>>> > @@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>>> >       tcg_insn_unit *gen_code_buf;
>>> >       int gen_code_size, search_size, max_insns;
>>> >       int64_t ti;
>>> > -    void *host_pc;
>>> > +    void *host_pc =3D NULL;
>>> >
>>> >       assert_memory_lock();
>>> >       qemu_thread_jit_write();
>>>
>>> False positive, because the error return exits without using the
>>> uninitialized value.
>>> But if we do want to "fix" this, do it at the beginning of
>>> get_page_addr_code_hostp.
>>>
>>
>> Acknowledged.  Gotta hate false positives, although better aggressive
>> than not. Thanks!
>>
>>
>>>
>>> r~
>>>
>>

--000000000000e4d34b062f72d088
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">And interestingly enough, it appears that execution contin=
ues even with early return from get_page_addr_code_hostp:<div><a href=3D"ht=
tps://gitlab.com/qemu-project/qemu/-/blob/master/accel/tcg/translate-all.c?=
ref_type=3Dheads#L308">https://gitlab.com/qemu-project/qemu/-/blob/master/a=
ccel/tcg/translate-all.c?ref_type=3Dheads#L308</a></div><div><br></div><div=
>Which implies that we could still have an uninitialized=C2=A0value here:</=
div><div><a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/acce=
l/tcg/translate-all.c?ref_type=3Dheads#L362">https://gitlab.com/qemu-projec=
t/qemu/-/blob/master/accel/tcg/translate-all.c?ref_type=3Dheads#L362</a></d=
iv></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Mar 3, 2025 at 11:34=E2=80=AFAM Peter Fole=
y &lt;<a href=3D"mailto:pefoley@google.com">pefoley@google.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr">For reference, the full output from msan looks like:<div><pre style=3D"=
color:rgb(0,0,0)">=3D=3D4872=3D=3DWARNING: MemorySanitizer: use-of-uninitia=
lized-value
    #0 0xaaaac681ef98 in tb_gen_code third_party/qemu/accel/tcg/translate-a=
ll.c:358:21
    #1 0xaaaac67f2520 in cpu_exec_loop third_party/qemu/accel/tcg/cpu-exec.=
c:993:22
    #2 0xaaaac67f154c in cpu_exec_setjmp third_party/qemu/accel/tcg/cpu-exe=
c.c:1039:12
    #3 0xaaaac67f1240 in cpu_exec third_party/qemu/accel/tcg/cpu-exec.c:106=
5:11
    #4 0xaaaac681022c in tcg_cpu_exec third_party/qemu/accel/tcg/tcg-accel-=
ops.c:79:11
    #5 0xaaaac680ede4 in mttcg_cpu_thread_fn third_party/qemu/accel/tcg/tcg=
-accel-ops-mttcg.c:95:17
    #6 0xaaaacf096698 in qemu_thread_start third_party/qemu/util/qemu-threa=
d-posix.c:541:9
    #7 0xffffa9242cec in start_thread (/usr/grte/v5/lib64/libpthread.so.0+0=
xbcec) (BuildId: 0bdac2117d4465a78d3de57b307368b4)
    #8 0xffffa912ec98 in thread_start (/usr/grte/v5/lib64/libc.so.6+0x116c9=
8) (BuildId: 613d20d3b812b4c87fe9ebf8c4caae83)

  Uninitialized value was stored to memory at
    #0 0xaaaac681ef94 in tb_gen_code third_party/qemu/accel/tcg/translate-a=
ll.c:358:50
    #1 0xaaaac67f2520 in cpu_exec_loop third_party/qemu/accel/tcg/cpu-exec.=
c:993:22
    #2 0xaaaac67f154c in cpu_exec_setjmp third_party/qemu/accel/tcg/cpu-exe=
c.c:1039:12
    #3 0xaaaac67f1240 in cpu_exec third_party/qemu/accel/tcg/cpu-exec.c:106=
5:11
    #4 0xaaaac681022c in tcg_cpu_exec third_party/qemu/accel/tcg/tcg-accel-=
ops.c:79:11
    #5 0xaaaac680ede4 in mttcg_cpu_thread_fn third_party/qemu/accel/tcg/tcg=
-accel-ops-mttcg.c:95:17
    #6 0xaaaacf096698 in qemu_thread_start third_party/qemu/util/qemu-threa=
d-posix.c:541:9
    #7 0xffffa9242cec in start_thread (/usr/grte/v5/lib64/libpthread.so.0+0=
xbcec) (BuildId: 0bdac2117d4465a78d3de57b307368b4)
    #8 0xffffa912ec98 in thread_start (/usr/grte/v5/lib64/libc.so.6+0x116c9=
8) (BuildId: 613d20d3b812b4c87fe9ebf8c4caae83)

  Uninitialized value was created by an allocation of &#39;host_pc&#39; in =
the stack frame
    #0 0xaaaac681d8ac in tb_gen_code third_party/qemu/accel/tcg/translate-a=
ll.c:297:5

SUMMARY: MemorySanitizer: use-of-uninitialized-value third_party/qemu/accel=
/tcg/translate-all.c:358:21 in tb_gen_code
Exiting</pre></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Fri, Feb 28, 2025 at 5:26=E2=80=AFPM Patrick Venture =
&lt;<a href=3D"mailto:venture@google.com" target=3D"_blank">venture@google.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2025 at 1:38=E2=80=
=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org"=
 target=3D"_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On 2/28/25 13:23, Patrick Ve=
nture wrote:<br>
&gt; From: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" target=3D"=
_blank">pefoley@google.com</a>&gt;<br>
&gt; <br>
&gt; e.g.<br>
&gt;=C2=A0 =C2=A0 Uninitialized value was created by an allocation of &#39;=
host_pc&#39; in the stack frame<br>
&gt;=C2=A0 =C2=A0 #0 0xaaaac07df87c in tb_gen_code third_party/qemu/accel/t=
cg/translate-all.c:297:5<br>
&gt; <br>
&gt; Signed-off-by: Peter Foley &lt;<a href=3D"mailto:pefoley@google.com" t=
arget=3D"_blank">pefoley@google.com</a>&gt;<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0accel/tcg/translate-all.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
&gt; index d4189c7386..f584055a15 100644<br>
&gt; --- a/accel/tcg/translate-all.c<br>
&gt; +++ b/accel/tcg/translate-all.c<br>
&gt; @@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_insn_unit *gen_code_buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int gen_code_size, search_size, max_insns;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t ti;<br>
&gt; -=C2=A0 =C2=A0 void *host_pc;<br>
&gt; +=C2=A0 =C2=A0 void *host_pc =3D NULL;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0assert_memory_lock();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_thread_jit_write();<br>
<br>
False positive, because the error return exits without using the uninitiali=
zed value.<br>
But if we do want to &quot;fix&quot; this, do it at the beginning of get_pa=
ge_addr_code_hostp.<br></blockquote><div><br></div><div>Acknowledged.=C2=A0=
 Gotta hate false positives, although better aggressive than not. Thanks!</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div></div>
</blockquote></div>
</blockquote></div>

--000000000000e4d34b062f72d088--

