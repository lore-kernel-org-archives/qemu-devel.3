Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2108CFD9E0A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 20:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vviEo-0004vV-DF; Thu, 26 Feb 2026 15:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vviEm-0004vK-Dy
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:45:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vviEj-0006Je-Uy
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 15:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772138727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3wu1MQHr6K/f3ybOzGlHBIYOGlpEw+u0vN90AxKt+g=;
 b=hXTMeHIRGNFPkzipuls96BruEYcrIEWp2UundS3u1yjjz8A8N0PHW4uSXajL8AB9hEbY4C
 A+qBK2zLdvPPnpHHTIDCKuTeLLcq5XU4/zdkFEc3Knyl5wzVqfTSmHBImIAreQqZSl7w0x
 JmQoUV6o07px7SKlpK/3265TGb+ZjB8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-wfsXXJHaNdmHzQBj-q8AYg-1; Thu, 26 Feb 2026 15:45:24 -0500
X-MC-Unique: wfsXXJHaNdmHzQBj-q8AYg-1
X-Mimecast-MFC-AGG-ID: wfsXXJHaNdmHzQBj-q8AYg_1772138724
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64caa85b132so1821089d50.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 12:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772138724; cv=none;
 d=google.com; s=arc-20240605;
 b=I2G1sdvXD5xoTSRHPVS452TxX/KqiFx4VTrgMd9G3UXHNURgO4KFcTzt5/7k/NanCZ
 kHzlVI1hnDsLKS1u108B9w/BSFhup6ksGLZSEIqHsudFmLYPlRxMcOe2gFHMsYqNL6df
 bmDcwSKmu/24hpSxZOaHegAhzCh+d9aIlaa72KmRaAuf6uoG0/f3t4wjjxHJ37c6MA4P
 M82L82CWGlc3YJ+rQGqE9jAAA8AwfIPox08ijtHVAXbIatfL2w/RK0xaRQLY4xmNfiIo
 +atcb3W3Oz3lLSXhsiACSaptIMdpowY41MQooN7mG3ih+kiEE6B6BcumhIcLRWR5CLRy
 N5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f3wu1MQHr6K/f3ybOzGlHBIYOGlpEw+u0vN90AxKt+g=;
 fh=lXYQx2vP+5+M3p9Sgkl8QU+vQSq7cMicNVTo4GVgWPU=;
 b=Hkl5zIutCWnIPdVilEFJOV19+0HDs7PTjiyFqAiTuhtx0g5HJCC73LashbctoW0kE/
 81eASjFllUdcIA09DI3h1LmOYc9klj2HEq4/Nlr+zeakL8RfpO0bjVfKESL3fER69YHM
 eZPmW0V+oy4iGW8Zv83iHalN6lg+KsZg7awK72X9W4147QzagIMdbbNll4ja3VBkpgRq
 6sNz5xPZzb+rCwcKIyEilGy0wUVopjwtrZvjZdbKY0rN9ZdXLBA97ZL/OxeIuE/2E9Q7
 m506TxoSlN5we/hFHN2ra8u8MswWp3GYZ/9yVyOAfXvySVdr+iWhWPNvVmsbhtQoK4Z+
 Ro4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772138724; x=1772743524; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3wu1MQHr6K/f3ybOzGlHBIYOGlpEw+u0vN90AxKt+g=;
 b=KVsgfH7cy61ZlII5nkDEyVM31lEciElx5aX4nF//6UcyO+WwPnsrzX+rPnyo134rOA
 patUD+/fZndddeAn2Up/fQ3iikLK5T2Cp3zyGP25Frt5fjyi/F4VMkA+LWKSS7YJ2N9u
 SCbzrf6eJfxMuM7lbqP/LKOgSTX0/vHO9esaf93lZwepLIuXr9kLgxgewAwEnAv2af5G
 FzjFlt2Wy59+6pGIPhacHQBqaGf1L3D4KXzGwAQeJ0dTv70bQT53qnIELiWo1OnYiQ6m
 PoVVwun6cQVWESr1N3fK/y+STCawNP7NTFdu1aS1V05cZrl9W99rL6uh7/G9QOnutukx
 6k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772138724; x=1772743524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f3wu1MQHr6K/f3ybOzGlHBIYOGlpEw+u0vN90AxKt+g=;
 b=XfyotBkmFGRngf94ZseoZMn6rSFr6BzMa6Eh7dg1Ex4T6q6JAP7RLHPnwEqDwdwZz6
 BoQjWelTEgp76SgraXDUC6P1iQpneBmrayW6yB/GOeRCGsrejJJpbar0ZhRJ//RyvDM8
 lf6ipofd0iqiNMODT7NIYNETZwx+Kvy8xN4m4DFakqxyzqSSfRUppdgM1/+i2pA3gQ5m
 LDsNO47tybJxGRN/O2bFQYlWpRb4ngpaYu+ngehyWhq1NzGi4on3+gRfRJJssjUXbkV/
 kLEMK2K7p3yDCwGCluyBpneGLChkSCrUXtLdXpuqkpkTK1btm+Mh1BQt6rHx6Fnk3/Ng
 vsMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQdJRJUdddZnhU9KSVbG1Z9TQHMRdo0JAer4OhrYThJhSZMqaszGGzS7yUWr+03mD8YzdhpQ0yLbs/@nongnu.org
X-Gm-Message-State: AOJu0Yz/+sDE21vdGeUa9M1WOAKp8+75E367VBfRww7BmqmURxnPl1xe
 ldxaVqifNZ8Qt5+jExuA5UTh3WE/8kgPdh7J3JZjZ30ndoAl99AaxbxtDjQQ3YOleQEVW6dJD6/
 +nz6SJjfkNnqf3FGLs1dwcf8ITIbtSzo3wp0v8C9wQsek8ebMHl5LgxMRiALUeFkyLSi04ZPu4A
 uaRK9X4csfPEeAnUYKQR1XN2SkfjUGUHE=
X-Gm-Gg: ATEYQzx/da5L74fiy+ou8OKyTNifbhod/zhyxSy+ilEJYI3DLo3QSOkpo+G8Srf5qIP
 0ITIK2jCaBYXlF4PKEQTSEAtORmrxGyhzqv9k3Q5oD5c+Pbn+ncqwJ99AIndEbM37rWK+IiTx41
 aP5/MetSuVotQJg0zel44EDFfnEfPzaifprTOMpi0LCsooreTVYDefj2HnmJDVgGmkihCCgOkdO
 IkKcNGtWpjTU2OoEjcaY3LrSLQvRU7p9WNUKg==
X-Received: by 2002:a05:690e:258b:b0:649:d604:fb70 with SMTP id
 956f58d0204a3-64cc2225319mr410619d50.54.1772138724319; 
 Thu, 26 Feb 2026 12:45:24 -0800 (PST)
X-Received: by 2002:a05:690e:258b:b0:649:d604:fb70 with SMTP id
 956f58d0204a3-64cc2225319mr410599d50.54.1772138723866; Thu, 26 Feb 2026
 12:45:23 -0800 (PST)
MIME-Version: 1.0
References: <20260225191255.955585-1-jsnow@redhat.com>
 <aaBOxS7bCODGq4Ry@redhat.com>
 <CAFEAcA-BHr4h+2U8DOU73PFSFSNakixeUSk_9iT9iCg6+f1X2w@mail.gmail.com>
In-Reply-To: <CAFEAcA-BHr4h+2U8DOU73PFSFSNakixeUSk_9iT9iCg6+f1X2w@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 26 Feb 2026 15:45:12 -0500
X-Gm-Features: AaiRm52ipadye9IXQ0tcyJQaXUE7X_Jc1FI_-G7aN9-JylfXvQUGvOm8Modsn3o
Message-ID: <CAFn=p-Y2L+CYcShO-op3sMC9CXSGWBs5XtmTtQ4GS860sEOx3w@mail.gmail.com>
Subject: Re: [PATCH] configure: allow PyPI access for python 'tooling'
 dependencies
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 12:52=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Thu, 26 Feb 2026 at 13:47, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >
> > On Wed, Feb 25, 2026 at 02:12:55PM -0500, John Snow wrote:
> > > We actually do not allow our meson requirements to be fetched online
> > > because we strictly prefer the vendored version. Move the tooling gro=
up
> > > installation to a different invocation that does allow PyPI to be
> > > accessed when configure is run without explicitly disabling PyPI acce=
ss.
> > >
> > > This will allow QEMU to download and install python3-wheel for you if
> > > you don't have it in your host environment.
> >
> > IOW, with this patch the behaviour is now:
> >
> >   * Host  python3-wheel -> already works
> >   * No python3-wheel -> auto downloads
> >   * No python3-wheel && --disable-downloads -> fail
> >
> > previously the 2nd case there was behaving the same as the
> > 3rd  which was wrong.
>
> Thanks; I've applied this patch at John's request to git to unbreak
> builds for people who happen not to have their distro's python3-wheel
> installed.
>
> -- PMM

Thank you, and apologies for the minor fuss.

I've updated the changelog to reflect this new requirement:
https://wiki.qemu.org/ChangeLog/11.0#Dependencies


