Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2216ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 13:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIS9q-0004yS-LB; Mon, 10 Nov 2025 08:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIRvB-0002xa-IQ
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:27:02 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIRv9-0002bG-KB
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 08:27:01 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b727f330dd2so510839666b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 05:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762781218; x=1763386018; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x48dGn/Spvae+OTcg52lOibkV+Gstcydqj7ETh7bQt4=;
 b=QvNT4uL4AMA5xhZuQmd3tYKLAFsWIvQvwuKeUwqskh8br918h1sHX9LTWNd02pFQQQ
 ij8ISdyfAak7vDkPCVoAfMBk/KAO+HeEP16rrbbwyLh1czKjVk2LdKB3Tlmtgn0CqQIG
 8rstFPOXq2Gkxk287Lz45/1FmiOZn+P6kfW727/gHdedrB812U2IH1HTcDjxKHZVt7Uy
 RGVEayBYroLbQ4meV6k2kDcbD8W1pWH8BCQld0TuEIaTIgPWysDBXIDEDC3MscaNyHzi
 TjkCNgwDqspvXHrykqtoxH7burEnKVmhAj7yfhU5x9V7G3/+FKgNzR9nfXenREXVVtYw
 Tebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762781218; x=1763386018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x48dGn/Spvae+OTcg52lOibkV+Gstcydqj7ETh7bQt4=;
 b=RT/iRIKNB644hvE9lMeU0KAVuleWMs9F1Gh9czEF2lY6IWNUdlG5WDqOFbVi217U6m
 sn2Tu2QXyvFtbjU4HLo9n1U3w2HQRIIAAjiNWj/laO0AoVka6N/9kiPpzAAuXtqz4XrJ
 /NVzISB+bQQ0z0mdBHqx1KmxGtVXKQ2NO+vdvVI2LPOp1Fi4KN9dJ8FQRs1JV0T+clmo
 PmWyWhFIoTIInaWQ1BwRNClqCZToSuWjkiGt81MhHL45xAyvOZmkLDE72dRQpNuUxh0c
 VMjpy0AuqCmYVll54lv9alxmvZPiqwvVSHRbb+CkiQtIg8frrlGgRMGQuD4Ys5mpu06m
 UfKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXMxtb9LxHgQ6yHVaFFGGMdb1xJ8XJEyzLAZl+Lg/vOu0Z83gg8N+VjhzyaQmcaZpi/SQIvNQakUdi@nongnu.org
X-Gm-Message-State: AOJu0YzJlCOxxFsLaI6HST8yPCDwaeBTzUB8cVazt0XMNmRFEIJB25Ba
 wvppGmUbpRDLDNQt4A+BGhKONzzJ3gx9ib5owaK4D1gBcW5IfBFpDtyod9FCKfwj43SvLXVSXG+
 ZO756NydPu69Zx5sbcOzFKi3CbmDqMNpq1b93M0fV
X-Gm-Gg: ASbGncu7/rBn/ubPEavrnWmWWKfuIRlJoQjw6dORkkRk6Y71HCZDn8e4bBRrH1909c0
 uWmKrgNjZtOi0iN0gLNF3YdixeBhEwqCC8PQbUGp2CNXkOCsnQjZ6eENiQlkHplj0q6JI0leVJg
 dW6maKo6skIVONpRMe8dqMznVUMuR+EnVyBk0BDYy7SHCwarf5wMTTRuGOey9cbVX3DOeUeUcBx
 qG+Q1z3hAbxW+Bgvb1IGPgBwU1DGJke8R2nKUfRaom0L2W8qw3dD0sHilzd3SUUTT0vhSc=
X-Google-Smtp-Source: AGHT+IHKwmsFknPEyYxmunFfwpPI7O9g7iTkMghPqCKNRAwKzMaWspK3X5IdQhYj7xHOns35FOYj+TLuDqX5+Xnm+yo=
X-Received: by 2002:a17:906:16c3:b0:b73:91e:79c0 with SMTP id
 a640c23a62f3a-b73091e7ad4mr228878666b.52.1762781218016; Mon, 10 Nov 2025
 05:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-6-chigot@adacore.com>
 <87zf8umbzh.fsf@pond.sub.org>
 <CAJ307EjObqJ6Pr5N+WrEffTr3pWOpRCKVVamZhCG9ZgwHczVYw@mail.gmail.com>
 <87bjlakpa5.fsf@pond.sub.org>
In-Reply-To: <87bjlakpa5.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 10 Nov 2025 14:26:46 +0100
X-Gm-Features: AWmQ_bmHtc5BRHDTKaiPw8oHeftYIEmdrFSFhG7jv1zh1-8gF3aeR6AokpCMxtA
Message-ID: <CAJ307EjZwiGj3N93Td9vA0JHyK0COZBXHqv-7cjpxxg+eKiisg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vvfat: add support for "fat-size" options
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x62e.google.com
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

On Mon, Nov 10, 2025 at 2:09=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>
> > On Mon, Nov 10, 2025 at 11:13=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >>
> >> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
> >>
> >> > This allows more flexibility to vvfat backend. The values of "Number=
 of
> >> > Heads" and "Sectors per track" are based on SD specifications Part 2=
.
> >> >
> >> > Due to the FAT architecture, not all sizes are reachable. Therefore,=
 it
> >> > could be round up to the closest available size.
> >> >
> >> > FAT32 has not been adjusted and thus still default to 504 Mib.
> >> >
> >> > For floppy, only 1440 Kib and 2880 Kib are supported.
> >> >
> >> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> >>
> >> [...]
> >>
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index 8a479ba090..0bcb360320 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -3478,11 +3478,17 @@
> >> >  #     (default: true)
> >> >  #     (since 10.2)
> >> >  #
> >> > +# @fat-size: size of the device in bytes.  Due to FAT underlying
> >> > +#     architecture, this size can be rounded up to the closest vali=
d
> >> > +#     size.
> >> > +#     (since 10.2)
> >> > +#
> >>
> >> Can you explain again why you moved from @size to @fat-size?
> >
> > Just to be sure, you mean in the above comment, in the commit message o=
r both ?
>
> Just to me, because I'm not sure I like the change, but that may well be
> due to a lack of understanding of your reasons.

Naming `fat-size` instead of `size` ensures the parameter is only
recognized by the vvfat backend. In particular, it will be refused by
the default raw format, avoiding confusion:
 "-drive file=3Dfat:<path>,size=3D256M" results in a 504M FAT disk
truncated to 256M, raw format being implicit.
 "-drive file=3Dfat:<path>,fat-size=3D256M" is refused. "fat-size" is
unsupported by raw format.
 "-drive file=3Dfat:<path>,format=3Dvvfat,fat-size=3D256M" results in a 256=
M FAT disk.
 "-drive file=3Dfat:<path>,format=3Dvvfat,size=3D256M" is refused. "size" i=
s
unsupported by vvfat format.

