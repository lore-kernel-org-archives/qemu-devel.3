Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86797C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp8ks-00083W-SX; Mon, 03 Mar 2025 11:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1tp8kl-0007z5-Ih
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:34:53 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pefoley@google.com>)
 id 1tp8ki-0008D8-PX
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:34:50 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c11ddc865eso1110699fac.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1741019687; x=1741624487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xz+fubSb9FwPazyiSyyizDm71YzJT6JANhv6cjxUCoE=;
 b=FFnpNUOhtgExz6IkYShht+qJgXCMaxtEjIbb3OSX5pqukzG/gHvzmP8zcRZiyY62TN
 kDL2Fu6Xt2j9XOJ680ShBms37DbT91j3htUwr3IYa7RtUs0pRK16jkxMA0rNTapMlSkN
 FTlFrxQVoPQMH9qziPrUqBljJhO/SIDutcGnHBo+ZHD7mhQzdOav+GOx6koGO4uB32pj
 Yv3Tp9cqgpH8vJB1wkxIyW9aqwnBGvKBup+ZpaeqeV29OqViz4fzMyUTQwoMpr0zQu0s
 +QBoV+RuhmD8y1jbxMr6Xw1r9Oxr4mw0huKa7NRqlXZqtnwUDwCBOO/3ua0sc3OT704n
 54HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741019687; x=1741624487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xz+fubSb9FwPazyiSyyizDm71YzJT6JANhv6cjxUCoE=;
 b=p0FNq8rpZhLNJFYMoTMTXB8H861KCi99tFD2UHFExt9vI9LXz4B8Nfs5s0aOtiltM3
 t5bWhcs3qTRfUzGp814lT39LtKI0sm4qk5nj7bYbbh0vooaZ3tdIBp6bvLoEgBm8ZMwS
 tpbPoosOuRFVc0vzr6Ek3s4wipL0LQu1Ho624aKICH9skjvyFKhoVWbvikP5VtLNF29o
 aLPul2HmsTLTTxYR7xdFQGDMVBnRMwAtiYPqZyYrsTmuwg9Zyw0jFtll+kjObtWJ6xZe
 bgMyl9eSn/M/c5otM8zlSZA1PyesjxZckvqrgwoPlaArNgF5BlSecmGFZzAotD5SAhDp
 okvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbpTv7U0Md+YaF+5+OLZaWoLbtEikoYAkzgBORP5d0f6f4LJPU+o6uXIF2KS1mnxvMCRmmU2pbnZn8@nongnu.org
X-Gm-Message-State: AOJu0Yx+i0xP/P+o0E+8osUd3XyCUQ5Oxj3WAow7dZk5T9E9QS3HzhDT
 rZZtrHrt+dPNXI1fNd5xQjYQlY1SOeWARggMDGmn9zVT6G0IvYrbMLfxYYlhV3pwP5NQxxyc+Cq
 3lGRk8eQXQ/7oECCdrF73KVk9Nwf4P0EdD9QvqxBXgVnoC8jfDAH1
X-Gm-Gg: ASbGncsRoIOiBzQbN4qCuqC8ZmeqqKhYy7GLFHHmKb8opQtqeYSMoK/ivLJMDU2LBwL
 U5b8IANfePs5m6745EKxnuPdq3hNCmV8Fum6O1wULY73yvkGuG0aPHf/r6YNRulWiAR2WBTzJp3
 rjCy7H8j6QvSemqkDfCPJ964d6Gz6eRyH+SYWpe7yXHxq8GSh5vxVzIKA=
X-Google-Smtp-Source: AGHT+IG66u4PWAocT1w+fa3TIl3EpvHigJwUZ68xo9evSPIuLaYC/pvxGXUVqGtC+jUfGToitMxa/OqkmgNGmgNCm2A=
X-Received: by 2002:a05:6871:410a:b0:29e:7a13:1341 with SMTP id
 586e51a60fabf-2c1783cd5bfmr7701631fac.8.1741019686688; Mon, 03 Mar 2025
 08:34:46 -0800 (PST)
MIME-Version: 1.0
References: <20250228212329.1775669-1-venture@google.com>
 <7771abbe-ab3f-43d8-9ac6-9ea0bc63b243@linaro.org>
 <CAO=notwzQsC7oJZxY_Jby9znX0ov62AVXsTENb7tagEBR2DcWQ@mail.gmail.com>
In-Reply-To: <CAO=notwzQsC7oJZxY_Jby9znX0ov62AVXsTENb7tagEBR2DcWQ@mail.gmail.com>
From: Peter Foley <pefoley@google.com>
Date: Mon, 3 Mar 2025 11:34:35 -0500
X-Gm-Features: AQ5f1JoyRQK2iqwGL8XjMqQzrEWUaMi9ZXWOJuc9jV2UDASn33GqFC1kqq8ZsaE
Message-ID: <CAAAKUPP_mK2VApyCOf2N3twYfn_fe5P5Y_OMhmCSqP1HrhZSDQ@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: fix msan findings in translate-all
To: Patrick Venture <venture@google.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f9494f062f72bb5d"
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=pefoley@google.com; helo=mail-oa1-x33.google.com
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

--000000000000f9494f062f72bb5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For reference, the full output from msan looks like:

=3D=3D4872=3D=3DWARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0xaaaac681ef98 in tb_gen_code
third_party/qemu/accel/tcg/translate-all.c:358:21
    #1 0xaaaac67f2520 in cpu_exec_loop
third_party/qemu/accel/tcg/cpu-exec.c:993:22
    #2 0xaaaac67f154c in cpu_exec_setjmp
third_party/qemu/accel/tcg/cpu-exec.c:1039:12
    #3 0xaaaac67f1240 in cpu_exec third_party/qemu/accel/tcg/cpu-exec.c:106=
5:11
    #4 0xaaaac681022c in tcg_cpu_exec
third_party/qemu/accel/tcg/tcg-accel-ops.c:79:11
    #5 0xaaaac680ede4 in mttcg_cpu_thread_fn
third_party/qemu/accel/tcg/tcg-accel-ops-mttcg.c:95:17
    #6 0xaaaacf096698 in qemu_thread_start
third_party/qemu/util/qemu-thread-posix.c:541:9
    #7 0xffffa9242cec in start_thread
(/usr/grte/v5/lib64/libpthread.so.0+0xbcec) (BuildId:
0bdac2117d4465a78d3de57b307368b4)
    #8 0xffffa912ec98 in thread_start
(/usr/grte/v5/lib64/libc.so.6+0x116c98) (BuildId:
613d20d3b812b4c87fe9ebf8c4caae83)

  Uninitialized value was stored to memory at
    #0 0xaaaac681ef94 in tb_gen_code
third_party/qemu/accel/tcg/translate-all.c:358:50
    #1 0xaaaac67f2520 in cpu_exec_loop
third_party/qemu/accel/tcg/cpu-exec.c:993:22
    #2 0xaaaac67f154c in cpu_exec_setjmp
third_party/qemu/accel/tcg/cpu-exec.c:1039:12
    #3 0xaaaac67f1240 in cpu_exec third_party/qemu/accel/tcg/cpu-exec.c:106=
5:11
    #4 0xaaaac681022c in tcg_cpu_exec
third_party/qemu/accel/tcg/tcg-accel-ops.c:79:11
    #5 0xaaaac680ede4 in mttcg_cpu_thread_fn
third_party/qemu/accel/tcg/tcg-accel-ops-mttcg.c:95:17
    #6 0xaaaacf096698 in qemu_thread_start
third_party/qemu/util/qemu-thread-posix.c:541:9
    #7 0xffffa9242cec in start_thread
(/usr/grte/v5/lib64/libpthread.so.0+0xbcec) (BuildId:
0bdac2117d4465a78d3de57b307368b4)
    #8 0xffffa912ec98 in thread_start
(/usr/grte/v5/lib64/libc.so.6+0x116c98) (BuildId:
613d20d3b812b4c87fe9ebf8c4caae83)

  Uninitialized value was created by an allocation of 'host_pc' in the
stack frame
    #0 0xaaaac681d8ac in tb_gen_code
third_party/qemu/accel/tcg/translate-all.c:297:5

SUMMARY: MemorySanitizer: use-of-uninitialized-value
third_party/qemu/accel/tcg/translate-all.c:358:21 in tb_gen_code
Exiting


On Fri, Feb 28, 2025 at 5:26=E2=80=AFPM Patrick Venture <venture@google.com=
> wrote:

>
>
> On Fri, Feb 28, 2025 at 1:38=E2=80=AFPM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 2/28/25 13:23, Patrick Venture wrote:
>> > From: Peter Foley <pefoley@google.com>
>> >
>> > e.g.
>> >    Uninitialized value was created by an allocation of 'host_pc' in th=
e
>> stack frame
>> >    #0 0xaaaac07df87c in tb_gen_code
>> third_party/qemu/accel/tcg/translate-all.c:297:5
>> >
>> > Signed-off-by: Peter Foley <pefoley@google.com>
>> > Signed-off-by: Patrick Venture <venture@google.com>
>> > ---
>> >   accel/tcg/translate-all.c | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
>> > index d4189c7386..f584055a15 100644
>> > --- a/accel/tcg/translate-all.c
>> > +++ b/accel/tcg/translate-all.c
>> > @@ -298,7 +298,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
>> >       tcg_insn_unit *gen_code_buf;
>> >       int gen_code_size, search_size, max_insns;
>> >       int64_t ti;
>> > -    void *host_pc;
>> > +    void *host_pc =3D NULL;
>> >
>> >       assert_memory_lock();
>> >       qemu_thread_jit_write();
>>
>> False positive, because the error return exits without using the
>> uninitialized value.
>> But if we do want to "fix" this, do it at the beginning of
>> get_page_addr_code_hostp.
>>
>
> Acknowledged.  Gotta hate false positives, although better aggressive tha=
n
> not. Thanks!
>
>
>>
>> r~
>>
>

--000000000000f9494f062f72bb5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">For reference, the full output from msan looks like:<div><=
pre style=3D"color:rgb(0,0,0)">=3D=3D4872=3D=3DWARNING: MemorySanitizer: us=
e-of-uninitialized-value
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
Exiting</pre></div></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2025 at 5:26=E2=80=
=AFPM Patrick Venture &lt;<a href=3D"mailto:venture@google.com">venture@goo=
gle.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28, 2025 at 1:38=
=E2=80=AFPM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linar=
o.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On 2/28/25 13:23, Patr=
ick Venture wrote:<br>
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

--000000000000f9494f062f72bb5d--

