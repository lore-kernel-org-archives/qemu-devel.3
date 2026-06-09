Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00490CD8C9D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWm97-0002De-M4; Mon, 08 Jun 2026 22:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWm96-0002D3-4u
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wWm94-0005tE-Fr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780971887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/HzVH/2rpWLa/CP7lKXsxgjI+kAx9QHWT3lwveqOME=;
 b=SfgAA3zQp4nm5kpESOcm98yvRqSzEzbw5dVgKEstN+AlhB/fH4yRzkkGQ2jYBwKs16jp9a
 CuhnC+h94bZZIBccpcTbMIpdr1h1OMzK7+wV6mip74TWAdhtNwHPxLJwO12NpC7TUr6m/C
 kBJf7GyVR8BtxKHuG+RJ0LDIMKUhCl8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-s5sfuoM-P4Wk0SfvsRwt8g-1; Mon, 08 Jun 2026 22:24:45 -0400
X-MC-Unique: s5sfuoM-P4Wk0SfvsRwt8g-1
X-Mimecast-MFC-AGG-ID: s5sfuoM-P4Wk0SfvsRwt8g_1780971885
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cced8f230bso115207266d6.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 19:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780971885; cv=none;
 d=google.com; s=arc-20240605;
 b=QF7+z/26YJky4JbZzq7Ph8sC6FKd85gByNb6g5VSGQ01GObUihQ6XIY7Uuc4HbnBSU
 7j/MvNNIfobrGULiKP58jSmII1Js4c4m0Hxd6kIL9MNfK7of/4NKBl+ce7AsrZ+So/Ft
 Z/LQh+pzD0mrVGqiw4/aSyzZTa4yMAvJst5fKo+qLhmVaKigwjjok5eGWbiPCX3tjOnN
 2DXagUSxTiswtzy8Smou5+I5WhMbYNh84mv6NwlkOg5FdBaoyHDE33QJZF+ugjzQrJ0a
 0Mc3zYpdtTyEmye+7GI4+6ScMx1wNM/AYwtnvYh5EgbdVS61jsAL40QAdot5BxkCLLtA
 DFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4/HzVH/2rpWLa/CP7lKXsxgjI+kAx9QHWT3lwveqOME=;
 fh=UCZv47SDFLBp2xnH8/hkTb/m8AN/uXjfay13T08eN5g=;
 b=fDMfFV2gIEflA0arJsSEd3NK+t3JEoyd1HqrAsncecYluU/jlHfq6fKef2yscqW3nz
 2G8TnRPWDxBWmwBbUeDgDSm4zRZc5JU8E5TGJw+WmE5Izk+28zg1p4l9F8eAjQRXkwWp
 Sl41XcD5+EKbc1RsNZy1f0itp+o+YYTrbpnsXysNakcBpzHtMakc0zJuVwg62s2OWhYh
 3DfCHGJLbLDD2BGmAO3nPqbbb69SgPJau18j80hLXspoSarU7quCJbdmw29uITn7h0bM
 /JcWU2rDxDjoph7xs+zhhsye0g+P+vCwmBvaARTrIl1gFeXOOJ0i+jNaGYN5c/wlSEBT
 qFIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780971885; x=1781576685; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/HzVH/2rpWLa/CP7lKXsxgjI+kAx9QHWT3lwveqOME=;
 b=C6iY1yXOF/Ud/Pa9YSC2h6ixmcYYnp2uo/HqRaGDDKAqe6GlWzFS1pdtttJH2WxJhT
 M5aKtk9VJH6vCuuHmEXmz0Js2cdy6le9sXiaymdAIhEXgevzR6TzXavsPO2g1F0ocD0O
 AazgWv5dLddbQi4jHVC8ZYEA6fqYbKa8jRa4eJxKzmHnlOLMFRyE12QzSzB8ijhf2lwl
 AOXBQr/+TYaJE+V8wCjjCy3svLtv7a8rsG79Rg+doBBRflGD3lZEvNRMlZqTNhmn+yMD
 OUVfSFII3jmhU22ZY3VxRcF1ZkYU+56HIaLOgOHg+P7V2AkJl6gZM3nxkDDok+ExSfOj
 mAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780971885; x=1781576685;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/HzVH/2rpWLa/CP7lKXsxgjI+kAx9QHWT3lwveqOME=;
 b=LFXX3Ni6wBQ72AdBWYgbagPmcsfUXqi6HGj+o60d9kXe9kGBvsKiA8xXrSfqmgYZsA
 r670c+avj1JAG0a3AhoK5hSJvcgXeqZZW4JBZUU0Fh7nH4MYUeCDJ1JSnc7pvsh93L7y
 8MMf+7UO9NoSBaRF55kIwBIFuvnhY9ShrP4BdU3T46Nei6heAbYk/YLZy71hWHC/lHwU
 mSeDzWHi2XJ7PkAltSisV7CQRgnZqNdoxX3ermDgmnXk1dRAEKrC8/KPhtaZDWNDzNj8
 t77vBUqGIL0QclB+0FkCzqlH22rLcB6H7fc5XuC4I7gTkr5Nhw3pZm1tTSueJpQuyv8J
 cXcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+D1zhGJh08MbVnkSrnXrJNduD893jxcix2wI6J8GvyIP6BCCd4mej4a6d20WF9lJBa2tdt8mxwRHzu@nongnu.org
X-Gm-Message-State: AOJu0YyjRAo9lgCi7tgcbUmvvhwGhmRsq/LMX7PEWZ3X5GB0uXFaOGk6
 wovDPVSW2r2gM4fCSD9/uSHGap0WDRxVIgAq9MKxmJuBWBChUv3oButcLuzh0gPvEdMVP30LVpX
 rm9kMuyCRznUWmKKMX8JWw+TdqJ6IMQlwy91/gu6cXPobN2UFP0+fJuLzmw4bqkBHrzxfEL+ilw
 iExiUvsuBIVIlJzWvY/xncegebbaQnp6o=
X-Gm-Gg: Acq92OE++CsnHnjMtxS1Y0CfCmfkol5kOF9Jmqj5DYR9uWf9CkCrtszfOF+ZEyZ0IT1
 MBkuUgC6JPs9takeJvJr0r2LvQ7RyAxw90Axg9Rw40rABnV6yWSZdDP8idHPkumX9jYzxiAaex+
 TD3+1cHd1fhRYnrZmd3lpSdL+7yS5kQE2Btx+kmtUN11C36o9l7TbIM39roMJBL/CyUJ2zQfbnX
 XVEDxwVYVRLpGAtul+e46HvK6gzv4SXcEagchFNfzYXWYffxvOkn0lpIUbtMzMqTFQSjRm0A9FR
 5fl3sSo=
X-Received: by 2002:a05:6214:610d:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cee5f9e773mr289251816d6.9.1780971885255; 
 Mon, 08 Jun 2026 19:24:45 -0700 (PDT)
X-Received: by 2002:a05:6214:610d:b0:8cc:6c08:552f with SMTP id
 6a1803df08f44-8cee5f9e773mr289251536d6.9.1780971884824; Mon, 08 Jun 2026
 19:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3XEhMNqHbkL2P6Xg3_hJ8WAxhPQgurjvuZg-vXUDZ5=x-RRA@mail.gmail.com>
 <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
In-Reply-To: <f2516211-6fbc-4714-b674-4276464f94ff@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Tue, 9 Jun 2026 07:54:33 +0530
X-Gm-Features: AVVi8CecqwK1KkVqgJ0hPcammCV5H9mWQ2aPCnc5EY9FqgHGESBtE87C_loxTvg
Message-ID: <CAK3XEhPdaVqi9nECrJrcRaCKK0bVcRXw=t6hXM=EVwbxpu5wLA@mail.gmail.com>
Subject: Re: artifact download for qtest
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel <qemu-devel@nongnu.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jun 8, 2026 at 10:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 30/05/2026 16.56, Ani Sinha wrote:
> > Hi,
> >
> > I am trying to write a qtest for which I need an IGVM file. I have the
> > file, about 54 MiB in size.
>
> 54 MiB is quite big,

I was able to reduce the combined size of 2 files to about 400K
https://gitlab.com/anisinha/qemu/-/commit/6aef476b59443dd1bc570c29e8e5ca431=
40cfed4


