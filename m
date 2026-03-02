Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5B6E9B37D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 13:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2vk-00021T-W4; Mon, 02 Mar 2026 08:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vx2vZ-0001zD-Ob
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:03:15 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vx2vW-0002GN-AR
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 08:03:12 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-65bfc858561so8019121a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 05:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772456586; x=1773061386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFTsXPMUmXMrhb+WDCUSo/rJtIDimcpm7eF+QMVSDTE=;
 b=KjkkqgkWPvBIeEUbVu2LgQZ6RAsVnTxudQy3D6ZNSMU+YGHEBW7/J4RA3li9VEUO6C
 8U+Fu8B+B64kQfvzmE/1R35+HHMv8/4k38q+OWB7XTTW1qqrefzp2cmWx+5XtgiEVCS2
 cgkvXBrw2Rkwe3r7u4W5BZsjxNQLtZ/8O/r9MAbCiXQZQKl/jDs/v+FbRLPrDC+wDllY
 cN1ZMxraerdlOvJyoL9lIL/3MuvEkSeYp187SKB7HOHYkKXPkIw+0nMpR/4U9vE3cQLC
 I4yTHoBUx8SG6MAw3MGH9EC99kCWRn9u1iP0UQIn4e1u6VtDCLZaQYKJAcVFeIdn6Qe6
 J+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772456586; x=1773061386;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aFTsXPMUmXMrhb+WDCUSo/rJtIDimcpm7eF+QMVSDTE=;
 b=SX+grpXV5wGibqtQzkkNTREVqQMOmx7Ipe5QFzTpZHN63bGX1SwIxG9zTEUDhMUkW+
 xNKx9ATGhyPBneHf1GE2FO4ezGwmC4I7bR+tC2Yk3ZSK4B0Lb1/XlkwFTb57m5WEOeT5
 pDmG/iVqFCwNuEQty8yhEANMIQePJoWAYKeW34KnxMfnMBfyEJFLj4ZNzORz/2wc1iwW
 SRhRDcedcDFrtf/DqWVxQADwQtOJIN3JR/TeXHPMgrjHq4WMvWDKa2LL/AC5RzRzTnJ2
 tAkmQCjsNewdDJIXWLehPJTjCN+kLJVn4INrIHpSDLwmGXmtCh3fzwm5tAVci2IYrm2h
 wKeA==
X-Gm-Message-State: AOJu0YxQYrQ5sCgq7BjVKLRYSgvNxN4a19PoNO30e2NC6hjiiKntuAFa
 wAGZ3ynUsx4eLxKMcueSL+qKsGqGd3zdv5m167VEDWkoQAl1QLlMRJFaHV2vaS/saNA=
X-Gm-Gg: ATEYQzxFC+/dwOVY0hDD/G1+DrErotj802DZ8oQLyeqhOoTFR4sZIW4LP6YuG682peK
 Vi/IiaXXLVpvCQHzQ6QSS3aA8ZI9QwfjYpgzeO1I3CFVqBFULlpQ2gWlpeS1nH5kt7KGLXL5IY2
 BNffIrthzAWzNbR7Z7x3bKU0tn+UkuQCEwkiIuhuC7LXjhYNfiph2hyUi65smjc3z9Bma1OilJU
 e8DmL4tPnx0JzR8ZQlWCJ1qi9KGK00MmrBNNY3/AJfCIx0I0XdA08B7HJide+TjTBqxefMB+ABm
 4NysHXEs/ugTBCVEGtLmGe9dg24/fdksDYPKoAAPi6zIOuCux18K+kTNV25BKKiAUOJBl5CMZnF
 VEmeJ8DUGYDQQ//G/FTK9XJzavuqblNzRBS7dBDGizhhJbYrCGlKS+BMCNghPEgxUFZVSHKokKR
 EB+n1DcqmhouVVlU47mdHgda4=
X-Received: by 2002:a17:907:6d20:b0:b93:8643:156a with SMTP id
 a640c23a62f3a-b93864318e2mr706456666b.16.1772456585398; 
 Mon, 02 Mar 2026 05:03:05 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ae93348sm465568466b.46.2026.03.02.05.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 05:03:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 559405F7BB;
 Mon, 02 Mar 2026 13:03:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 6/7] plugins: prohibit writing to read-only registers
In-Reply-To: <519b075a-e216-458f-b258-4d255c8e5c8e@epfl.ch> (Florian
 Hofhammer's message of "Mon, 2 Mar 2026 12:52:04 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <cc5b7b1a-b562-4376-8e4c-f01607bbcf9b@epfl.ch>
 <87ldgi2fr7.fsf@draig.linaro.org>
 <519b075a-e216-458f-b258-4d255c8e5c8e@epfl.ch>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Mon, 02 Mar 2026 13:03:03 +0000
Message-ID: <87ldgacrjs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> On 24/02/2026 18:49, Alex Benn=C3=A9e wrote:
>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>=20
>>> The opaque register handle encodes whether a register is read-only in
>>> the lowest bit and prevents writing to the register via the plugin API
>>> in this case.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>  plugins/api.c | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index b2c52d2a09..3a8479ddce 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -424,6 +424,7 @@ static GArray *create_register_handles(GArray *gdbs=
tub_regs)
>>>      for (int i =3D 0; i < gdbstub_regs->len; i++) {
>>>          GDBRegDesc *grd =3D &g_array_index(gdbstub_regs, GDBRegDesc, i=
);
>>>          qemu_plugin_reg_descriptor desc;
>>> +        gint plugin_ro_bit =3D 0;
>>>=20=20
>>>          /* skip "un-named" regs */
>>>          if (!grd->name) {
>>> @@ -431,7 +432,6 @@ static GArray *create_register_handles(GArray *gdbs=
tub_regs)
>>>          }
>>>=20=20
>>>          /* Create a record for the plugin */
>>> -        desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>>>          desc.name =3D g_intern_string(grd->name);
>>>          desc.is_readonly =3D false;
>>>          if (g_strcmp0(desc.name, pc_str) =3D=3D 0
>>> @@ -442,7 +442,9 @@ static GArray *create_register_handles(GArray *gdbs=
tub_regs)
>>>              || g_strcmp0(desc.name, rpc_str) =3D=3D 0
>>>             ) {
>>>              desc.is_readonly =3D true;
>>> +            plugin_ro_bit =3D 1;
>>>          }
>>> +        desc.handle =3D GINT_TO_POINTER((grd->gdb_reg << 1) | plugin_r=
o_bit);
>>>          desc.feature =3D g_intern_string(grd->feature_name);
>>>          g_array_append_val(find_data, desc);
>>>      }
>>> @@ -467,7 +469,7 @@ bool qemu_plugin_read_register(struct qemu_plugin_r=
egister *reg,
>>>          return false;
>>>      }
>>>=20=20
>>> -    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) -=
 1) > 0);
>>> +    return (gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) >=
> 1) > 0);
>>>  }
>>>=20=20
>>>  bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>> @@ -476,11 +478,12 @@ bool qemu_plugin_write_register(struct qemu_plugi=
n_register *reg,
>>>      g_assert(current_cpu);
>>>=20=20
>>>      if (buf->len =3D=3D 0 || (qemu_plugin_get_cb_flags() !=3D QEMU_PLU=
GIN_CB_RW_REGS &&
>>> -                          qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_=
CB_RW_REGS_PC)) {
>>> +                          qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_=
CB_RW_REGS_PC)
>>> +        || (GPOINTER_TO_INT(reg) & 1)) {
>>=20
>> Maybe this is better as:
>>=20
>>       g_assert(GPOINTER_TO_INT(reg) & 1 =3D=3D 0);
>>=20
>>       if (buf->len =3D=3D 0 || (qemu_plugin_get_cb_flags() !=3D QEMU_PLU=
GIN_CB_RW_REGS &&...
>>=20
>> again the plugin is trying to do something it shouldn't.
>
> As far as I can tell, there's currently no mechanism in the test setup
> to check that a certain assertion is triggered. In the previous test, I
> just checked whether the API returns false when I try to write to a
> read-only register, but now I'd need to check in my test whether the
> assert triggers.

Ahh I see - I was going to say we don't really need to test for abuse of
the API triggering asserts but you next test does indeed do that. I
think we can live without explicitly adding a test case for attempts to
write to read only registers.

>
> Should I check that in a wrapper script, test only the read path, or
> follow a completely different approach for this?
>
>>=20
>>>          return false;
>>>      }
>>>=20=20
>>> -    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT=
(reg) - 1) > 0);
>>> +    return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT=
(reg) >> 1) > 0);
>>>  }
>>>=20=20
>>>  void qemu_plugin_set_pc(uint64_t vaddr)
>>=20
>
> Best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

