Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F446CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBA98-0000d1-QV; Mon, 28 Sep 2026 08:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBA8k-0000aP-3b
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:07:26 -0400
Received: from mail-ed2-x0e.google.com ([2a00:1450:4864:33::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBA8i-0005so-7l
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:07:25 -0400
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aaea1cb2e4so3454726a12.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597242; cv=none;
 d=google.com; s=arc-20260327;
 b=RcsLYfnunPo8ovYdv9a/vfOPKnQlZRyxPoRC/+hpgfeamwCSNArTdTeuJMX++PnnGA
 iZnpe7QXn8pNqt7pKGP+vsPrT4L3M2JGCkXXWKiuxnIYxqcAylPlaffnCU5yoM0VWo/i
 KVhKCbn36e368nSgdDon6hhPXmMcQlRymBEBQjURnz/Ua1ERBzGO6b+j44MwdM2kg7Gm
 x9Lncx3NBzJUW5FmF7XvKz3cH46RQMVZK2EjixOI+kN1G6G/PBWnN0d0kzxb6mQRWXUW
 QnFAVolk0vVjLRbVhyiVHAJvfnstjRnafRRcUXMtNfF43HzsHezN41rLdxwaYr53UnmE
 Qn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3CcpjB61DP+jHViwLpHHAHnAOg6SGzxM5eQzcbI8tO4=;
 fh=6jdXT6b4cnfDza0iCJZs0pGSp8j3wtI2284GwcwH8j8=;
 b=GpPOhgx/Jk8EWmHt7WkozZGU7c+Cu3JXRqggGUW+f2we++IRTHySc680J6LLDv6ydH
 VlunS1mXAZX6a3MarbAVYn3EOzpHqk/0Dk4XckIuxws8a8FoHF7N3HrLkegAmLEZYI2q
 QxMVSLGVfVRds5cNyc5rSvsA1Q52pO73esiKzcvmLyfv+MTbOpiG7O2Cjua9okfT+LKg
 DLBUKi08X7Dy/bFAjBF6fyX6Kt4oxsQAvMldhB7HI2tFQV6Zg7SdTzgQezPAvSavVQBv
 prgGQ5YdH0a1BK3NJvtCPY3kukymUwu4UGUzNlVFBPffxQUGJCRPCwg1MRbaIsX/OJBy
 yjCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790597242; x=1791202042; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3CcpjB61DP+jHViwLpHHAHnAOg6SGzxM5eQzcbI8tO4=;
 b=X81RwiGZS4t7nIpg+RL/1Fd5FKAEYASNt9H3IHcYWBAnwGL0l4HtV5QBgtDYBUChg1
 9QzXIuktGgkI6/Z1V2KkpLELGJHwaGHCjIERaIHarooAet6JCvtcWetc2Z+bSH3mQ0O5
 CY0fg+sUREcDPUkR6kYtdNc1T6L7HtEQIYsygtbXJ2uSkX5eoPoKf45Ss+GSOSyqZRF7
 gA1gbtdqBwKeasYj8gcA5hlSMnSp/5neJrGyluZRBI8spgh6tlrS9oWRdD/gnb2Aic+g
 /mSvaYvszGeDcTFkPBY+S50sxfyXANv44Cy1CqirfWwpLJOOZ7uF0zUAIx5cCQv1mGx6
 WE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597242; x=1791202042;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3CcpjB61DP+jHViwLpHHAHnAOg6SGzxM5eQzcbI8tO4=;
 b=FG9f+Yl2//5scy9ENhT7fLBoyK/KJIsViDPcFusJHkuWRfi66zx6nlBiOSGT5/0unt
 akB1TTKUh1lE4zA7HTRoykHhEhaSWyfLYikkYC7Yv6uT9CbdkId38C6jCJhLpHfTCOTL
 DVk9KRbKjVnlT3nVczPL1ArOwJCabSd0uQjbDnCuPCKhdrm+UMjbkezx+cnXGIA7bo7M
 SH8uFhjodd2Tyki7GCMBnawlBXiMypFGYdNNmHDAdX07N/vWj39sdD/b/v0wFqnYuAmZ
 6Cres36Q817LqxlcbbqrwD8tYNDbUflPqkcsxaljYC9/76rMDFchlW6tHjVtAqCdNjip
 cuFg==
X-Gm-Message-State: AFq9FYJ20LmAVjiZh1CD0jzUPRtd7/YdJm7Wv0E8HW6iukjfy2VtTzUw
 OJfMZrIx0xsvaO/lBUWRX5r197jDlwBoq6XKCYtOQ5Kiujf6rYvzKz4R+w7IZ9il/+r7TkTWsJD
 F3xNSWQp3anMuEQekJGCgHOg5OABnjj4=
X-Gm-Gg: AYBFou2gswbLDhXfAUvXQtmlPeJLmtH63tbfhj3sT6pxbXyhvY/4YYGKM9eMEBEhAbY
 DnOjIbsMkWl4bs+jQquiwhYHwsPfTibIzBkEri+oQUmjnCCgDNIDlDa1j6YwwZ/Lvp7POJaB2Fw
 XgrHNRlkCVQBHxXfofeARYZ9f3rTg+A71eNTRHDjP5uuxZN7sL3ncIbc0aA1CBe26iKNPZGRitO
 tnPeATx9656Eiw0GgXoPTYjGIAj2f8kojB1Tek1/46hTPNeicIutdElUM0G6xKM/YBC5EsZc3MM
 MymH8LxnP/F43JFnqFmFvGV4Mp2smnvfDBIQWpRY7sFvx9czYxlOBkM=
X-Received: by 2002:a05:6402:2347:b0:6ab:1cd:a2b0 with SMTP id
 4fb4d7f45d1cf-6ab01cda539mr4643767a12.15.1790597242417; Mon, 28 Sep 2026
 05:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-41-luoyonggang@gmail.com>
 <8733uthabd.fsf@pond.sub.org>
In-Reply-To: <8733uthabd.fsf@pond.sub.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 20:07:09 +0800
X-Gm-Features: AclHuK_y1qd3j7vFq2hyn2hchpoS_W6rvrOx6-7dKHB17wLrD3LvwU7fi-xXUbk
Message-ID: <CAE2XoE_wr6XGoTEXrR6fvA5xuGXz8QMqQuRqo5zW8UzPt-MTBw@mail.gmail.com>
Subject: Re: [PATCH v4 40/55] meson: link shared objects into qemu-system
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000091f8d8065c89e8c7"
Received-SPF: pass client-ip=2a00:1450:4864:33::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000091f8d8065c89e8c7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 7:42=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > Extract common_ss, system_ss, and family-common objects into one
> > qemu-system binary. Only arm, aarch64, microblaze-softmmu are
> > listed; a new target must have arch_srcs equal to target_info_def
> > only (target-info-def.c). Config headers stay in arch_genh.
> >
> > - Union non-TARGET_* keys with y taking precedence
> > - Reject leftover arch_srcs on participating targets
> > - Reject TARGET_* conditions on common_ss and system_ss
> > - Link SDL, install the binary, and apply Darwin entitlements
> >
> > Adding a target that still has per-target sources fails meson, for
> > example:
> >
> >   combined qemu-system leftover for :
> >   expected:
> >   target-info-def.c
> >   arch_srcs:
> >   target/microblaze/mmu.c
> >   target/microblaze/machine.c
> >   target-info-def.c
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>
> Watch query-target lie:
>
>     $ qemu-system -S -nodefaults -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 11},
"package": "v11.1.0-1902-g88f617913a"}, "capabilities": ["oob"]}}
>     qemu-system: warning: nic xlnx.xps-ethernetlite.0 has no peer
>     {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
>     {"return": {}}
>     {'execute': 'query-target'}
> --> {"return": {"arch": "aarch64"}}
>
> Perhaps you can fix this by reordering patches.  If you can't,
> deficiencies like this one need a prominent mention in the commit
> message.

OK, this is worth a test, I'll guard it, I didn't realize there was a
query-target command before.


>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000091f8d8065c89e8c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 7:42=E2=80=AFPM Markus Arm=
bruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =
wrote:<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; Extract co=
mmon_ss, system_ss, and family-common objects into one<br>&gt; &gt; qemu-sy=
stem binary. Only arm, aarch64, microblaze-softmmu are<br>&gt; &gt; listed;=
 a new target must have arch_srcs equal to target_info_def<br>&gt; &gt; onl=
y (target-info-def.c). Config headers stay in arch_genh.<br>&gt; &gt;<br>&g=
t; &gt; - Union non-TARGET_* keys with y taking precedence<br>&gt; &gt; - R=
eject leftover arch_srcs on participating targets<br>&gt; &gt; - Reject TAR=
GET_* conditions on common_ss and system_ss<br>&gt; &gt; - Link SDL, instal=
l the binary, and apply Darwin entitlements<br>&gt; &gt;<br>&gt; &gt; Addin=
g a target that still has per-target sources fails meson, for<br>&gt; &gt; =
example:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 combined qemu-system leftover for=
 :<br>&gt; &gt; =C2=A0 expected:<br>&gt; &gt; =C2=A0 target-info-def.c<br>&=
gt; &gt; =C2=A0 arch_srcs:<br>&gt; &gt; =C2=A0 target/microblaze/mmu.c<br>&=
gt; &gt; =C2=A0 target/microblaze/machine.c<br>&gt; &gt; =C2=A0 target-info=
-def.c<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D=
"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt;<br>&gt=
; Watch query-target lie:<br>&gt;<br>&gt; =C2=A0 =C2=A0 $ qemu-system -S -n=
odefaults -display none -qmp stdio<br>&gt; =C2=A0 =C2=A0 {&quot;QMP&quot;: =
{&quot;version&quot;: {&quot;qemu&quot;: {&quot;micro&quot;: 50, &quot;mino=
r&quot;: 1, &quot;major&quot;: 11}, &quot;package&quot;: &quot;v11.1.0-1902=
-g88f617913a&quot;}, &quot;capabilities&quot;: [&quot;oob&quot;]}}<br>&gt; =
=C2=A0 =C2=A0 qemu-system: warning: nic xlnx.xps-ethernetlite.0 has no peer=
<br>&gt; =C2=A0 =C2=A0 {&quot;execute&quot;: &quot;qmp_capabilities&quot;, =
&quot;arguments&quot;: {&quot;enable&quot;: [&quot;oob&quot;]}}<br>&gt; =C2=
=A0 =C2=A0 {&quot;return&quot;: {}}<br>&gt; =C2=A0 =C2=A0 {&#39;execute&#39=
;: &#39;query-target&#39;}<br>&gt; --&gt; {&quot;return&quot;: {&quot;arch&=
quot;: &quot;aarch64&quot;}}<br>&gt;<br>&gt; Perhaps you can fix this by re=
ordering patches.=C2=A0 If you can&#39;t,<br>&gt; deficiencies like this on=
e need a prominent mention in the commit<br>&gt; message.<br><br>OK, this i=
s worth a test, I&#39;ll guard it, I didn&#39;t realize there was a query-t=
arget command before.<br><br><br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=
=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--00000000000091f8d8065c89e8c7--

