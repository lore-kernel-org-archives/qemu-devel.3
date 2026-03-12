Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D0BFED2D9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 07:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0a82-0003BS-4M; Thu, 12 Mar 2026 03:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w0a80-0003Aq-FI
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:06:40 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1w0a7x-0003Np-Pz
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 03:06:40 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6615c766e60so1128097a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 00:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773299193; cv=none;
 d=google.com; s=arc-20240605;
 b=YUIalGX8+S08ePM96e/dCuPD1u/Ql4aReiuDbrKmlSu4bG+Izkfgdr4zbs7pCXXHKO
 VCJjSyUbrsre1TNQxe4DNMh00tQEpLIySBJYALH+DbQAtyoJgC1o0vPt3d9rlBNmx8RD
 fNqp6TQ3MrfeaL16b0HEAZdabr2Fh9dmi50G5wi0DTF+QPu2BAjId55qjJKk8MNDglhC
 VmaL6TgxEDJsuz00hf5HPj6BYTb2XbhlPUXXJLbe7eAgFKajg/Lmi3lTpquGSiLb1sYk
 /F/AMUK14tniMUB3wdHwhCd69n66Xo6u+NjH0bjyfCx/qepUwKPD3s8qdwMzgILG88d8
 pBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s49gALuOGW8NBoBbBXOrB7km8sdLJ/5DTA0PiJICUAg=;
 fh=YY+0OZ78tipQ54hBnLc060Mh8vCSrZVvpFoPlsscYR0=;
 b=HLG2q1UNXrlLQFHoIj/uZ6JC0aIWb2XNFxn8vrHAlPcNbw/mu/aTkhzGiMUH6ecXhH
 L6E3UYZsfp9585f7wNYcj5jZvP0DW2go6xeHnTtjcJZ4G5kMyV3yyTkyqcja2TL8ogl0
 nsi2v0zH9ToxPlh8OfDiifc0uvbHa2fGyayvwbKEdogMoDQdp41o3zTOqueAxyh6yHAA
 hbbqKWohRP0bVHGN1k1zD+NawD3RR/Wmk7fhfnAB/0V57e/r9ApInmwTvncO9j6pNe/f
 MoltwU/Kq6XAI9JR9y20LSa92AdyhBWO3hRBHHfFAfZwLXqCEsdpMP/e1Xwp7sOvIx65
 3LEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773299193; x=1773903993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s49gALuOGW8NBoBbBXOrB7km8sdLJ/5DTA0PiJICUAg=;
 b=M1m7UgwnrGj4GWgpP7PvFQflvOFXHSrGHMZri/F3E+9/rPod3FPc5QXZDGIJCOPbPi
 jn9p8kFIHJf0gy+jz6141OYcZYLPlCEvu2KBVE3tKL24rm4Py3o/FjpbY+7jdL75IowZ
 vDqKOInxmcBe+vWmvSqrQYLS4lb/W1aRkjPuAhVLBuJczBjfAjwzT59LmjubTdbRrglc
 zsJU0tX4uLbbnjpPQxzgE6MOiNm7GhL4Y52/Hcf4aoUenSF0ASEPyHGCp4Lz1S8AQIf4
 svs3whXR48KrJh0FrSTTMKvUw4MxwGhryGa2rTZB5+cif7W49xN5ZUBl2L1bE/zdu1l6
 wj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773299193; x=1773903993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s49gALuOGW8NBoBbBXOrB7km8sdLJ/5DTA0PiJICUAg=;
 b=qiZDGvDlV5+htN8fYAotrap4Pdv50uv5TOr0tw2+rHXYeLgpjrc+iVk74E+KPKQnXC
 1J/O/IN98cF+rjHE5MLdRifuZTr0ALgi0+00WRdTlVe/k6SM6KEvu8V5DSxeN0gLyhqQ
 RmzN1n7e+ulP3ZRKz8Ng/0id02P0tZDCHLi8Udl1iRWCbe7Lau2g9h7RGk27wM6ylVoC
 FJp/uLw34NsEr8drIc2UwRV8nHBGp/4+RC+FwJ7oG9DUdzprJokZAY9PdbCIkvTuSfsp
 RzMMX55EHxuIxAzP97FQz6HdFJL36N/NzR3OREAckAl+RGguIyT3w5z3b+E4nmQo4ps+
 cptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyRaCT24m3g+SuCM1EAj3CuCgPdqJriQB4YMrDA7yyAfGQhDJ4hEZMmV0qtyF8aWzWuMA1LYkWqalZ@nongnu.org
X-Gm-Message-State: AOJu0Yw4xE5Dz9TmqBWtChduhNKS21RdJKA3uqa8JIv+0MhSzx/FEDsS
 /l9ZJrQ5gFhgyUf7GiHdU++opBX5J0MMNxx7F1yOhq6F8MeYtsfV/thFOfkqQtA/Cr1ajwSlOh7
 WxQHjUCLSTMnwSnhUUrc8dDle9xV3Q9U=
X-Gm-Gg: ATEYQzwfD9mrWBAT7otlJvrVlZeRLr2eiM9ZyyZoav3w57siCi36eEfvXRqRnzrDXYU
 jnaJgBxGopUJm/4iNpYmh+fcU8szbwA6Q+VC8KED8xl2yLq+iloqLX66lpn1MF7oCQZMdNrMABc
 KPb8N/YfKTw99KnLGThXFl2nOjRGG5MSNIvMNQNZg15c+IaMWWpyHisTyE+Bx7xQnIrd2pvwtd4
 iGI9Bf6eEdzg/VRDd68DItmbVMBMn4bPL5j3s/ken/RP/ppsKMoCwms/1eacbZ+Ec8F3O3nknJm
 EcjofljH
X-Received: by 2002:a50:cc04:0:b0:663:4821:f9c9 with SMTP id
 4fb4d7f45d1cf-6634821fc13mr969955a12.13.1773299192659; Thu, 12 Mar 2026
 00:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
 <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
 <20260312052422.GA116604@fedora>
In-Reply-To: <20260312052422.GA116604@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 12 Mar 2026 15:05:55 +0800
X-Gm-Features: AaiRm50cdQ4O8uWDTJ-u7MX9J4ZnoZQf2SbxSTctgNTenzI9y6GqZTM-430WjPQ
Message-ID: <CAK3tnvKPvJjsNCcmuEi7OOfM5xkC_PuDEgNR9cKFpEUMioiOww@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, Mar 12, 2026 at 1:24=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Tue, Mar 10, 2026 at 06:02:54PM +0800, Zhang Chen wrote:
> > On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat=
.com> wrote:
> > >
> > > On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> > > > Update the usage of "iothread_get_aio_context()".
> > > >
> > > > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > > > ---
> > > >  blockdev.c | 9 ++++++++-
> > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/blockdev.c b/blockdev.c
> > > > index 6e86c6262f..01ccf64b3f 100644
> > > > --- a/blockdev.c
> > > > +++ b/blockdev.c
> > > > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char =
*node_name, StrOrNull *iothread,
> > > >              goto out;
> > > >          }
> > > >
> > > > -        new_context =3D iothread_get_aio_context(obj);
> > > > +        char *path =3D object_get_canonical_path(OBJECT(bs));
> > >
> > > CCing Kevin and Markus in case they have an opinion on this.
> > >
> > > BlockDriverState is not a QOM Object so using OBJECT(bs) is undefined
> > > behavior and may crash.
> > >
> > > node_name is unique across block driver graph nodes and could be used=
.
> > > Unfortunately it's not connected to the QOM Object hierarchy. Maybe i=
t's
> > > best to build a holder name that is an invalid QOM path so there can =
be
> > > no collisions between QOM paths and block driver graph nodes.
> > >
> > >   g_autofree char *holder =3D g_strdup_printf("BlockDriverState %s", =
node_name);
> > >
> > > (A cleaner long-term solution would be making BlockDriverStates QOM
> > > Objects so they have a proper path.)
> >
> > If no other comments, it's OK for me. This issue like I mentioned in
> > patch 7 and 9.
>
> A thought about the QAPI interface:
>
> QAPI expresses as much information in the schema as possible, so I think
> the right approach would be a {'union': 'IOThreadHolder',
> 'discriminator': 'type', ...} that supports at least "qom" and
> "block-node". That way there are proper types to encode QOM Object paths
> vs block node-names. Let's avoid having a single string value that takes
> on different meaning depending on the type of holder.

In the iothread_get side:
The same issue in the patch 8 (the node-name too), the point is
qmp_xxxx_function input is a string.
It's hard to track the QOM Object paths and the iothread. I will try
to fill the gap.

In the iothread_put side:
* It looks like a pairing function is needed:
+         * qmp_x_blockdev_del_iothread()


Patch 8 comments:
+        /*
+         * It seems we cannot find the corresponding resources
+         * (the iothread and path) when deleting them in qmp_block_export_=
del.
+         * The original method will be retained for the time being.
+         */

# @BlockExportOptions:
#
# Describes a block export, i.e. how single node should be exported on
# an external interface.
#
# @type: Block export type
#
# @id: A unique identifier for the block export (across all export
#     types)
#
# @node-name: The node name of the block node to be exported
#     (since: 5.2)

Thanks
Chen

