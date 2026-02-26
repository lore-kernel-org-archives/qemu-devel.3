Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BA8FCE08C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 14:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvcR8-0008Tz-GY; Thu, 26 Feb 2026 09:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvcR6-0008Tj-2J
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:33:52 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvcR4-0004QZ-5T
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 09:33:51 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f92f3db6fso148926066b.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772116428; x=1772721228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kREfW1ZMezkxa5N5v6vMu50RWMTQLf1i8GI1pQ0Z4os=;
 b=JWjaGQmqvRalieZpxP0C/laeh0RuH4FQf1iS5IvOvUH4Y3+OQp0Ad1xrj4XBKXhmAx
 /UhRqonHwn22upBTrCcMAp0xvjems6IUR9Reme672k1ktXdM4V11tu7oiItRVz008sAg
 CbvNeoQoAu3FkBw2xY+ZlBNrn3HvFpsyNkCsVk7uvFc2wpzcifzelCrdTHmvD6S1z/8K
 CQptjjuCsIAYzgUMMeoMfBMcaj9HrLnSVd+61TCkJIIdjiSoLqg8iVLrNPnNns/EKF5u
 T0c9Lp+IGeRC51ilqXJ5VL8bqOsri2BsuuRKIw2N4HBdUtyEKgee4wr0UiwUoOddl0Nh
 kDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772116428; x=1772721228;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kREfW1ZMezkxa5N5v6vMu50RWMTQLf1i8GI1pQ0Z4os=;
 b=DV+IfzFUmDVpHy2p4h/0n63bqMV4p9k4kLFOwFm7n3STHfGkRzQYouQmzwWmrznJr+
 M6RSf+9VvbS3RcCqbGldMddb5HxNmrbyxqpMSqhBPnz9bEDaGqChok40UFUUcCY8AdmL
 3XNRS/icBxFANnz1+Wjoap7P8SufFuDJXLxLcFXfTHp15DcmXQM890cGiYvJQSIPP52j
 BSpJU4utWBra08tm0lbji6+M+QvBeAnVEFatLs1G/gce6hrPogFtJHLCEZXHJraFAkiW
 0AQRtkq+HVqe538YvOE6xVdSHXzrUVt1ZKoRQj7uDKC18V8Fj3hzY9pQZ+9aJ3GotnmX
 hgmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqzyfMUaUeW2JldAHDfuTBLGonnBYsT8iWzCrVdiqH+bijzszIxKa21LXeCbdnR/CAwItGOPyXM1lX@nongnu.org
X-Gm-Message-State: AOJu0YxWxQ5q2RjvSpG+DV8RBSEH4IGlVA44n9vhTnMwUnJfUATc4vAG
 uvCqtNAIQTJzwuzOfHkd3hoZZUxp42q61Qt7BtBYdMO/wZAqmcxexhQCHh7OIqDNR8U=
X-Gm-Gg: ATEYQzxkD936glxXqBrpGL4bMN8zUNVvAvtrtCs7B3Yz0n7/TEZeRiwXJDvr51ukSVu
 sTi7szutSkGPXPmk0/UX+gThRPMN7PDFcZyDxq49vtXVVSa7p/b/rM2lSuH0ShJkSXQycCFf5Se
 8ZUfkfyYkfAIPP/0LbLIknNBsovVO7Ym8EJYqPfN2f9InUtl7znYGcSiKjKu3lAUOH1hlCwsjmm
 GQsI7uXuckF4/NrVf8Du7g8TyKxuo0t1rlSqwi9kkVffb9O0zYmX/rAtmZ5yWPGK4hJXddyg/T1
 yuH/MWC3vA5K59YEowhwhhqnJ8hDyxvl+0X01Pox/eXp8Vp8/haKf6kwrJTrc6Nzpa6Yk6g2npO
 +pBSQDbCfa5kEPBho3ZVzsuNvTQUjdovv5/EH2Hu+sghOQmJLIHZWt5ZgdMzop72KgafCR7pVyQ
 GIk3SuN58KUtessOtq0TBJRXs=
X-Received: by 2002:a17:906:6d7:b0:b8e:d04e:e4fb with SMTP id
 a640c23a62f3a-b9081bc25e6mr1184030166b.48.1772116428061; 
 Thu, 26 Feb 2026 06:33:48 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab146bdsm65711066b.6.2026.02.26.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:33:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 619425F802;
 Thu, 26 Feb 2026 14:33:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: pierrick.bouvier@linaro.org,  richard.henderson@linaro.org,
 laurent@vivier.eu,  imp@bsdimp.com,  berrange@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 5/7] plugins: add read-only property for registers
In-Reply-To: <5e43b8f7-e8ee-4cd9-b8a7-f4b4761b6137@epfl.ch> (Florian
 Hofhammer's message of "Thu, 26 Feb 2026 12:55:06 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch>
 <5e43b8f7-e8ee-4cd9-b8a7-f4b4761b6137@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Thu, 26 Feb 2026 14:33:46 +0000
Message-ID: <87fr6nzi9h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

> On 24/02/2026 16:53, Florian Hofhammer wrote:
>> Some registers should be marked as read-only from a plugin API
>> perspective, as writing to them via qemu_plugin_write_register has no
>> effect. This includes the program counter, and we expose this fact to
>> the plugins with this patch.
>>=20
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>  include/plugins/qemu-plugin.h |  2 ++
>>  plugins/api.c                 | 16 ++++++++++++++++
>>  2 files changed, 18 insertions(+)
>>=20
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin=
.h
>> index 04c884e82b..ae711758f1 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -979,11 +979,13 @@ struct qemu_plugin_register;
>>   *          writing value with qemu_plugin_write_register
>>   * @name: register name
>>   * @feature: optional feature descriptor, can be NULL
>> + * @is_readonly: true if the register cannot be written via qemu_plugin=
_write_register
>>   */
>>  typedef struct {
>>      struct qemu_plugin_register *handle;
>>      const char *name;
>>      const char *feature;
>> +    bool is_readonly;
>>  } qemu_plugin_reg_descriptor;
>>=20=20
>>  /**
>> diff --git a/plugins/api.c b/plugins/api.c
>> index ca3e93a194..b2c52d2a09 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const=
 char *value, bool *ret)
>>   * ancillary data the plugin might find useful.
>>   */
>>=20=20
>> +static const char pc_str[] =3D "pc"; // generic name for program counter
>> +static const char eip_str[] =3D "eip"; // x86 specific name for program=
 counter
>> +static const char rip_str[] =3D "rip"; // x86_64 specific name for prog=
ram counter
>> +static const char pswa_str[] =3D "pswa"; // s390x specific name for pro=
gram counter
>> +static const char iaoq_str[] =3D "iaoq"; // HP/PA specific name for pro=
gram counter
>> +static const char rpc_str[] =3D "rpc"; // microblaze specific name for =
program counter
>>  static GArray *create_register_handles(GArray *gdbstub_regs)
>>  {
>>      GArray *find_data =3D g_array_new(true, true,
>> @@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbs=
tub_regs)
>>          /* Create a record for the plugin */
>>          desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>>          desc.name =3D g_intern_string(grd->name);
>> +        desc.is_readonly =3D false;
>> +        if (g_strcmp0(desc.name, pc_str) =3D=3D 0
>> +            || g_strcmp0(desc.name, eip_str) =3D=3D 0
>> +            || g_strcmp0(desc.name, rip_str) =3D=3D 0
>> +            || g_strcmp0(desc.name, pswa_str) =3D=3D 0
>> +            || g_strcmp0(desc.name, iaoq_str) =3D=3D 0
>> +            || g_strcmp0(desc.name, rpc_str) =3D=3D 0
>> +           ) {
>> +            desc.is_readonly =3D true;
>> +        }
>>          desc.feature =3D g_intern_string(grd->feature_name);
>>          g_array_append_val(find_data, desc);
>>      }
>
> While extending the tests for my patches, I noticed that there are other
> registers that are effectively read-only as well, such as the vg (vector
> granule) register on aarch64. I wonder whether there should be a more
> generic support in QEMU for this or whether this is something that
> should be handled by GDB instead.

I was chatting to Pierrick about this yesterday. There are also
additional registers I'd like to make available as pure read-only and as
they go through the gdbstub machinery that seems the obvious place to
deal with them.

> The difference to the pc in that case is that the pc architecturally is
> read-write and it was just QEMU who silently swallowed the writes to it.
> For the vg register in the example, as far as I understand correctly,
> this is not an actual architectural register, but something that GDB
> exposes as a read-only register for easier debugging, and QEMU therefore
> also exposes this register. However, writes to it with
> gdb_write_register and by proxy qemu_plugin_write_register are silently
> ignored.
>
> I'm not sure this is something that should be handled in this patch
> series but I'm wondering whether this is something you already had on
> your radar or whether this should be taken care of in a follow-up patch
> series. I'd be happy to get your thoughts on this!

I think this is fine for now - for future enhancements we should extend
the gdb machinery and then reflect that in the exported plugin
registers.


>
> Best regards,
> Florian

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

