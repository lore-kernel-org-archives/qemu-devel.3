Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9448CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 19:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8O3B-0005Tx-1h; Mon, 13 Oct 2025 15:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8O36-0005Ta-KC
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:17:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1v8O34-0001n3-94
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 15:17:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so32869105e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760383052; x=1760987852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiK75KG1lswxj6Jv8QlsEsjxImVje5ZiRRxRVvO5CtY=;
 b=D75GnJME5L6IuaXn2jm2B/HNoveBOWw7VSgfnWUxxkYso6agFPbgvccJtBnD99hL77
 ZvKzD51sntgkLjzQ9TymV7SJS/UiNpDaN0u3J/mLvmcoAExAgW4YJj0RkNTv+BSNcBcO
 NgHvaVfeqfXkGw4mtXdPa1/BQRK6cs0jidSTPSYKxvq6ihjg0P7V2DnRElvgWRUQPT1N
 oWaKJWPP/sr7MUB8noWjQCm5JaDoYdLjSItbtzFLIl4BmDA4Ty7wIDVCESiSxagoho44
 0ux95qI3phhl9gHVg6H2dMN5qb7MmObpKhNJx8t1/9H06fEYVHXIp22wvRJEmkqoXMjB
 vLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760383052; x=1760987852;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiK75KG1lswxj6Jv8QlsEsjxImVje5ZiRRxRVvO5CtY=;
 b=pBdMq6iPqPdlztStaJE0t+kpgkHCFB3rQI/P9HrkslfC4BugMyPL2LxGzHjzH6auP1
 VaklDxS57RmYxBHjrmrWx5atsuehws9YgHBXoOOMhTT9ok6MHNPanqvgjmpfnLN/GoQq
 5ntMLziExCuSTvRTMKsPr33fzUGxRKi+QAlT2CRanQYWoIRXBikEUjJiVWHb82SAV/jc
 qvE+KpzJBLFhDDqcLcr9SE/d+U4zGn16b/dKSyAxl2tqdO371wPuNdQZPc6MQD9g3q0i
 qtnd4WG1tWLFJ3N4x48ASPBORCu4PIEUzrjeW3WY6ouZqdDhrW0QhxapF/hb2PjjET95
 xbbQ==
X-Gm-Message-State: AOJu0YzdFJ5A2kn4W2M1RLJFBsW5AKbQvLlXUNhPT2s/qEhJustbmrEI
 +JXXrmiDMQSU/eroTNxNxKzydaUDWbNbAag9dWTta6cb5ON77Vh9+MHdDx8feQ==
X-Gm-Gg: ASbGncv8DrGI3rWFNpnDNdsH992hFQbjQ0q3rU4zxi1FWoGmDjF3CFLZqXPZP5bP/Ld
 NwGNbjaXlCrwid7Ri+Iqt8Jazkxz3pef0wdrpD1OknOD7OJumzzIypGrSp1FBXxBM4hvbB59Rqj
 xoebBRP6ZI7H44E79GP0uuRZf6mwdONhB44EaNz64ON3QY7mqwaaHQDRr9nnAIPRqRk1JUbavhZ
 HHauUj0cjuCFKmVBvr7vRowU2FvpZF9oJU8l4iAN2zfgBmVNaVQQupqSTy5jUy4sCPgFNI/7O1W
 K4C55fAPugZDUykhZFruTjJcc6iVROab8MH6L+zNL36X+0xm3DHDWQg+WIxozuBPTLjOqGyjKRa
 VRenjdAHVi46GiMzw0+b8511WBdNTuQCnxB/F923Gf/Ni3XHUNN8EkAY5rGHzHp9NNws3zooT/R
 JfvU3xJRe7UGGOPDSoULrFPHLtANu65Zz6clKPLw==
X-Google-Smtp-Source: AGHT+IHU5wMW6jHCaghZ+f5oYifMHLQNNFD/JSPcjf6kXUliBoNv9hhsI7yXKfx/FCdg5qEQ19dHsQ==
X-Received: by 2002:a05:600c:3acb:b0:46e:2801:84aa with SMTP id
 5b1f17b1804b1-46fa9a21caamr132516145e9.0.1760383051935; 
 Mon, 13 Oct 2025 12:17:31 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (p200300faaf271400a0afdc243fcb5392.dip0.t-ipconnect.de.
 [2003:fa:af27:1400:a0af:dc24:3fcb:5392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf790sm19028061f8f.28.2025.10.13.12.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 12:17:31 -0700 (PDT)
Date: Mon, 13 Oct 2025 19:17:28 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
CC: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, xen-devel@lists.xenproject.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/display/xenfb: Replace unreachable code by abort()
In-Reply-To: <877bwz6oqy.fsf@pond.sub.org>
References: <20250729111226.3627499-1-armbru@redhat.com>
 <877bwz6oqy.fsf@pond.sub.org>
Message-ID: <20C81C5B-912C-49B3-B50A-867C06C134B1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 13=2E Oktober 2025 11:10:45 UTC schrieb Markus Armbruster <armbru@redha=
t=2Ecom>:
>Ping?
>
>Markus Armbruster <armbru@redhat=2Ecom> writes:
>
>> xenfb_mouse_event() has a switch statement whose controlling
>> expression move->axis is an enum InputAxis=2E  The enum values are
>> INPUT_AXIS_X and INPUT_AXIS_Y, encoded as 0 and 1=2E  The switch has a
>> case for both axes=2E  In addition, it has an unreachable default label=
=2E
>> This convinces Coverity that move->axis can be greater than 1=2E  It
>> duly reports a buffer overrun when it is used to subscript an array
>> with two elements=2E
>>
>> Replace the unreachable code by abort()=2E
>>
>> Resolves: Coverity CID 1613906
>> Signed-off-by: Markus Armbruster <armbru@redhat=2Ecom>
>> ---
>>  hw/display/xenfb=2Ec | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/hw/display/xenfb=2Ec b/hw/display/xenfb=2Ec
>> index 22822fecea=2E=2E5e6c691779 100644
>> --- a/hw/display/xenfb=2Ec
>> +++ b/hw/display/xenfb=2Ec
>> @@ -283,8 +283,7 @@ static void xenfb_mouse_event(DeviceState *dev, Qem=
uConsole *src,
>>                  scale =3D surface_height(surface) - 1;
>>                  break;
>>              default:
>> -                scale =3D 0x8000;
>> -                break;
>> +                abort();

Don't we prefer g_assert_not_reached() these days, for more expressiveness=
?

Best regards,
Bernhard

>>              }
>>              xenfb->axis[move->axis] =3D move->value * scale / 0x7fff;
>>          }
>
>

