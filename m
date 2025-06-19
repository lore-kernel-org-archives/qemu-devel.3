Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB3DC77B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 18:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSKAI-0005fG-Ru; Thu, 19 Jun 2025 14:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uSKAE-0005ec-Vp; Thu, 19 Jun 2025 14:39:06 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <idryomov@gmail.com>)
 id 1uSKAD-0007f4-Ab; Thu, 19 Jun 2025 14:39:06 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235ef62066eso13529185ad.3; 
 Thu, 19 Jun 2025 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750358343; x=1750963143; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iD4LM1CZktZxWapBS5UB33ai9wuFW4H3I4OiQlgWQts=;
 b=Doo6pcHAM5ubq/4fLKehUve/N0w7NiL0vNXihlpCovJTP/eJhVFntWIry3eOh/dKgo
 abr3CJZwexBY84u/wSGCTVQ2hNZjcthE8uzeP3kSk34K89ROrxrothtzfyDFJzhsuGdY
 foqeIUVJBA+QHaUttZmympxjQRMluWCJRaDkVRypMYxsbr/iHgvSAl0A4saKsu6Kv+G6
 AALiZj9WmWW8zuoIrHnr9HENuTmEK/NkGazqWMSQ4e1P0zhVEYjjw2Gj5ffEfJvXL7Jf
 XdB4pKFqcTqfgoxCt2qCYSHTexAqKVVI6HTkyf/nchhEOYrvMUaM+j2VRtbrZI7glma1
 LyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750358343; x=1750963143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iD4LM1CZktZxWapBS5UB33ai9wuFW4H3I4OiQlgWQts=;
 b=hWdOD9vSsvBueN4PPKXG9mSQuU+bYbBQHVB8R/F3iG4Bl+0B2FfVV7JJWZcS3I4JKy
 QiFABHFSWeAX0BFrTu5pJgH6AoHp2jdkq/wsOVVebHIW8QXLxvzfyseeSfxsVJFUu7Jj
 f/r9IiBI6rvNImWghwvOPmv03dT62AhVviBPglT5eexEsq8+eVd8ISCO+sF4lhBQ9jXb
 ZxOFZAnIRAVuefCjFQ7ehwEkNb9ugmo9gGr+jaHj/4R9VkXitvNTKgcnaQcWloiCcVUa
 pmoT91q1rffgbc/qsrav5AiPH6jmwPDFqBMTZk+3FXhGMRNNa2046HhQyDydwm33ZxUC
 TG4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/Un1sti7DZGAzeC69kploKAt2KbcQNrjS5AYu8DstJeIH9ehRlVt2n1BxGqCqKGXQqf/Z3kknm3jtoQ==@nongnu.org,
 AJvYcCWAZvjXM+4OjkmrqyO3S5qFjI64ERmLFKWzUfyAv8Ndc+7xoBr7WPjZN5njApL2GrMcLWXDPbKszGc2@nongnu.org
X-Gm-Message-State: AOJu0YxtGtngcUFCruwCiToYbSGcfd577TcQuCiU6QktvcIEYs9SwByr
 xK3k0bOg1YaqxBMftwLWUcmyouF8svOTOMg/aEDhViuES5g56X0wL94EfTawNwhDFaToRxDxpaH
 1gvU+ZVbF2uaR0amevsPmCvpYmy+oOWM=
X-Gm-Gg: ASbGncsk5SD6Hij6JZ2wxWGIIdj/oxsLJfqJvpnYegdkZWWbv07lQ4MWgRXkPnYrkDA
 6g2sbtX286PJkKMyq6cHnKnMCJ4WSvXdcpzjEFKrbJ3Lc1h9dCSm0BEii6JAz1qtcQJrOo5KC6B
 gL0F33DvWy/HF1m0WYTD+oGE+OYB+MjPpXvzleR2PJ0RI=
X-Google-Smtp-Source: AGHT+IHz9MpRvB8HRqYm/0gtHeQfjxbIUgLw/DNGkpwOpeYVbjOo2KB0LWZZgi/iFy3z8ASbBvboh1almG9PnfZXArc=
X-Received: by 2002:a17:902:f683:b0:224:24d3:6103 with SMTP id
 d9443c01a7336-2366b3f78b9mr372429275ad.35.1750358343191; Thu, 19 Jun 2025
 11:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250515112908.383693-1-f.ebner@proxmox.com>
 <20250515112908.383693-2-f.ebner@proxmox.com>
 <CAOi1vP94WJ7r1vPXvcpGZTs2xf6TZ=p=EmVGQvwipftufaYAMw@mail.gmail.com>
 <aE_pbAS_gS12Fp8f@redhat.com>
 <CAOi1vP-oc0XHR28E7JrvZOohL7KZEq7LunYKHfb540W=a8t=wQ@mail.gmail.com>
 <4a7ca415-0d16-4b21-ad93-31c35f1a4511@proxmox.com>
In-Reply-To: <4a7ca415-0d16-4b21-ad93-31c35f1a4511@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 19 Jun 2025 20:38:49 +0200
X-Gm-Features: AX0GCFtbQrP8oNuDUDoqtUp8YsvSNwX_CnLLEpFzu6Ci7Uj8WMUw6e0b_xeai-c
Message-ID: <CAOi1vP8sazy4h=HcZyxE+EaC_C-5QnYezvwnJLzTCnz+=HM4hQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] block/rbd: support selected key-value-pairs via QAPI
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, 
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=idryomov@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Jun 16, 2025 at 2:38=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 16.06.25 um 12:28 schrieb Ilya Dryomov:
> > On Mon, Jun 16, 2025 at 11:52=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> >> On Mon, Jun 16, 2025 at 11:25:54AM +0200, Ilya Dryomov wrote:
> >>> On Thu, May 15, 2025 at 1:29=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.=
com> wrote:
> >>>>  ##
> >>>>  # @BlockdevOptionsRbd:
> >>>>  #
> >>>> @@ -4327,6 +4360,9 @@
> >>>>  #     authentication.  This maps to Ceph configuration option "key"=
.
> >>>>  #     (Since 3.0)
> >>>>  #
> >>>> +# @key-value-pairs: Key-value pairs for additional Ceph configurato=
n.
> >>>> +#     (Since 10.1)
> >>>> +#
> >>>>  # @server: Monitor host address and port.  This maps to the "mon_ho=
st"
> >>>>  #     Ceph option.
> >>>>  #
> >>>> @@ -4342,6 +4378,7 @@
> >>>>              '*user': 'str',
> >>>>              '*auth-client-required': ['RbdAuthMode'],
> >>>>              '*key-secret': 'str',
> >>>> +            '*key-value-pairs' : 'RbdKeyValuePairs',
> >>>
> >>> To side-step all of the above, have you considered implementing
> >>> a straightforward passthrough to Ceph instead?  Something like
> >>>
> >>>   '*key-value-pairs': ['RbdKeyValuePair']
> >>>
> >>> where RbdKeyValuePair is just a pair arbitrary strings (and
> >>> key-value-pairs is thus an optional list of those).  rados_conf_set()
> >>> would be called just the same but the user would be able to override
> >>> any Ceph option they wish, not just a few that we thought of here.
> >>
> >> Passing through arbitrary key/value pairs as strings is essentially
> >> abdicating our design responsibility in QAPI. enums would no longer
> >> be introspectable. Integers / booleans would require abnormal formatti=
ng
> >> by clients. API stability / deprecation promises can no longer be made=
.
> >> and more besides.
>
> Yes, and I also was under the impression that there is no desire to
> re-introduce arbitrary key-value pairs with QMP/blockdev options.

Hi Fiona,

What do you mean by re-introduce?

>
> >> Given that limitation, if we did go the string pairs route, I would
> >> expect it to be marked as "unstable" in the QAPI schema, so apps have
> >> a suitable warning NOT to rely on this.
> >
> > This sounds sensible to me.  We can continue exposing the most common
> > Ceph options through a proper QAPI schema but add key-value-pairs as an
> > alternative low-level route for those who want to avoid dealing with
> > physical configuration files.
>
> As written in the commit message, the cache option should not apply to
> all volumes, so using configuration files is rather impractical there.
>
> I'd prefer defining the cache option(s) explicitly, and have people add
> additional key-value pairs they require explicitly going forward. But if
> you really don't want me to, I can still go with the unstable, arbitrary
> strings approach instead.

The RBD cache policy option would definitely count as one of the most
common, so I don't have an objection to it being added in an explicit
form.  I'm also fine with the "disabled" enum value that you expressed
a preference for in another email.

Thanks,

                Ilya

