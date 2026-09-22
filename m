Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88903C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97hw-0007dx-0M; Tue, 22 Sep 2026 17:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97ht-0007bq-Kt
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97hs-0005GI-24
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 17:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790111235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3T1a0uTgrtj1q08tU4l+fhE5cLikzJZ5N7DVyUsx7yk=;
 b=gcLzAVR4tLoFwrzdRpV3pco+79DkCAkNffdTXXvKUfhCDp5wOPtH5JeHztMifhjiHVDNWt
 FKj/2ncGvZoTwH/sh/INOcgihtRIzSJYRu0UO71tm1KYEga9F9lX9e4ZATCrvYkfnoXI9X
 SFutJjt7MZfPxPCsAKrO70HxOD5Gmbo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-fwJg53KWMqiTkWt6XtpThQ-1; Tue, 22 Sep 2026 17:07:11 -0400
X-MC-Unique: fwJg53KWMqiTkWt6XtpThQ-1
X-Mimecast-MFC-AGG-ID: fwJg53KWMqiTkWt6XtpThQ_1790111231
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67149af6070so593699d50.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 14:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790111231; cv=none;
 d=google.com; s=arc-20260327;
 b=X8IaqMZLIv204z8GZTsvZPBz60KumJRUhPva6a8G5xkTkmrzTHBGXIhC/vR9nfrwt/
 oXkF6X22Pn1kqnx23T0ffQeuVB/SoUilijqEEcZeQIkj3it0Q9B4607OYm34CRj8n6jM
 +loGwlHAArSuXqUoMzEaJW4oFeUDMz1pL5ApZUBT/ZfDoShx6rnvt47Kw7BH5z7yYDMY
 nSKawWd6cmCs6kvATVe/Kwt2dnVxo3tUtMjH9qi6loNFw/qXKJgepSGwP60x3gRQfI/i
 Et6nhHFEbVUDliGMBIYnr3auU836BoIvTTI7nzFsBucP6mu1ykJ4C8vkXmGqnXJ4xGlf
 yTtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3T1a0uTgrtj1q08tU4l+fhE5cLikzJZ5N7DVyUsx7yk=;
 fh=HggjP/8GTcSTTJqWLQ4IKk3lBbpDDmOG4QVBwEsA1HQ=;
 b=RlPCOmZ57ajWiSnpYVjhwnFSsHSjQxmMbuyiOSUDloYHvCmKBxbnchMBwB33E1lBAk
 LgIRedytxcM7/zHhPz+fGxCM7PXCnYKwDiLS/FTDh8mqrDurBicyhA57hSpqyQusl+FN
 HLuqVOD/xRb3OE/x398MoG5NqPgP8Fv799pduit1uW1HiaK9vLtk8xqW/Gq8a/x/Fh5h
 3+bi1QZe0mwXfOmK7Il+vqcqrzbDK0CJe12s605bBeQAalo8IezVHK5UCZPUhYBMzk5W
 BTqj5LX1P3glHfwG+xgucwfXWGcGusZaaQzw1bKWQX9ikXaOLRgTlCoDGWK98o2f/VIi
 PWkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790111231; x=1790716031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3T1a0uTgrtj1q08tU4l+fhE5cLikzJZ5N7DVyUsx7yk=;
 b=KTDJI4s5wfu9OQKazcK1dsjgoAmC8rol8lGYDwhnh2RPqDu+/qt4YRw6FD2FQ1XJGs
 ztyqbjlTI4yswARY0rdWBvSEqlsC/cWPE13VFklwE/I2hyjBSAnOfjfWSYt1HnyUCCaP
 s9EVtU5yfm+HVEN9rmdawFuHdo6ngCcSsmX0Sq+F83rZKF3scnyDw7XOs46zslD5KhWP
 G3iyiXlUWg6C7q6TXt1UmP542axDkI1aQ/BrYKuYP/9+eNax8z5gwvR/u1PgxkfhEk9x
 1HHXcQfRh8cxZlvHVLK8+PwM447w2uhhWpd0BJbJehXoYOqjjKcXirUC4tK913x/gkq5
 sS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790111231; x=1790716031;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3T1a0uTgrtj1q08tU4l+fhE5cLikzJZ5N7DVyUsx7yk=;
 b=u8A/1Lp9LRf0uinlCVrwY5JcrDEufyllQRwyLi0m/+j0yU6pnzKGbhDuW6KhZzLP9z
 txJFch7At695KLRCR8EI3JM8UDYkYQnEB9ExtNdjkNjueHKAm81olBVemKrwlXlIHWix
 9+XvO5+/ONYdPprDZnFoOV157udsvuw8NMgZpaKENdMdpTKt6noA4nPL24RbS6CihnGC
 xriIh1h56EAKIwS7Fb7fwgUQL+vkksxps+OPDHX7NsViS16K1udEq8JfWkdmMp0ZMq5W
 UrtgWfC8WMxR3UnD+0z9jE01Bso/tDnznf9+ApmMFi/lNZ6HI88vjLITm3Wr3pXlIUeX
 3dVg==
X-Gm-Message-State: AFuF++mAxxvLMHJcm4tpm9bsAYUNbUOEAL4ixPLH48qN3j88kiFNJ6/G
 q45vjr0EV2WFuwvERVibWtg6YCkOGhSGX7W5RDMfkXnxgs+lrMUlyKy5/+w7GMUsPCmkF+y8JjV
 fe8Z1QNlGsnCjoiXkJFaayKgZ6Ee86AyW9IgF0Q8BoUOFNdqgeUjLEThj8hxdXGn2bEyE+EwpTo
 I66xuBxfuoLsafF6EgtqZzk1R+vX58bN8=
X-Gm-Gg: AYBFou0zpGUsaLOPxr8AKzqg5gIuQKxelUpb4+XAmbf2al8Xjmk5EGSeof8CughGUAW
 fUw3dkt6eaVfeA7CCChsHKHon2HFyZYu35YUwH/1xSdeOChYoDOSy+EBJ++tA7svGyHhvzgVczu
 DdJmOeemB/61KwWHrXOtGnWvR2EWhR0Ml7/VI9mv2Ro1rezSNLJJddo4Ohw83v7yaWBSC7vscJC
 Y715DElUO64icVwXBFEKOcDz84=
X-Received: by 2002:a05:690e:128a:b0:672:d1c8:d1e9 with SMTP id
 956f58d0204a3-672d5737077mr477703d50.7.1790111230707; 
 Tue, 22 Sep 2026 14:07:10 -0700 (PDT)
X-Received: by 2002:a05:690e:128a:b0:672:d1c8:d1e9 with SMTP id
 956f58d0204a3-672d5737077mr477692d50.7.1790111230344; Tue, 22 Sep 2026
 14:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
 <20260923-nohmp-v1-46-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-46-ebc029d4bd80@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 22 Sep 2026 17:06:57 -0400
X-Gm-Features: AcwNN1WirYFmWkdgZAmk4iAvmjFh_w7pisMZzZn4sOyzz2QDIkXlsAGkKVYOWno
Message-ID: <CAFn=p-Z-K5i7B8f4Abo8RrnedW9r_MMMjKRDid_oexBm468w2w@mail.gmail.com>
Subject: Re: [PATCH 46/88] qemu-iotests/045: remove HMP monitor dependency
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 22, 2026 at 4:21=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Test 045 (TestSCMFd) is adding a null HMP monitor via
> add_monitor_null() to exercise fd operations with two monitors
> present. With HMP disabled, -monitor null is no longer valid.
>
> Remove the add_monitor_null() call and the now-unused method
> from the Python machine module.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  python/qemu/machine/machine.py | 7 -------
>  tests/qemu-iotests/045         | 6 +-----
>  2 files changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine=
.py
> index 393750655589..71b4696227f6 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -202,13 +202,6 @@ def __exit__(self,
>                   exc_tb: Optional[TracebackType]) -> None:
>          self.shutdown()
>
> -    def add_monitor_null(self) -> None:
> -        """
> -        This can be used to add an unused monitor instance.
> -        """
> -        self._args.append('-monitor')
> -        self._args.append('null')
> -
>      def add_fd(self: _T, fd: int, fdset: int,
>                 opaque: str, opts: str =3D '') -> _T:
>          """

Fine by me so long as block folks are okay with dropping that part of the t=
est.

ACK

> diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
> index cd1b35edb17f..900bf85220f7 100755
> --- a/tests/qemu-iotests/045
> +++ b/tests/qemu-iotests/045
> @@ -129,9 +129,6 @@ class TestSCMFd(iotests.QMPTestCase):
>      def setUp(self):
>          self.vm =3D iotests.VM()
>          qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
> -        # Add an unused monitor, to verify it works fine when two monito=
r
> -        # instances present
> -        self.vm.add_monitor_null()
>          self.vm.launch()
>
>      def tearDown(self):
> @@ -172,5 +169,4 @@ class TestSCMFd(iotests.QMPTestCase):
>
>  if __name__ =3D=3D '__main__':
>      iotests.main(supported_fmts=3D['raw'],
> -                 supported_protocols=3D['file'],
> -                 require_hmp=3DTrue)
> +                 supported_protocols=3D['file'])
>
> --
> 2.56.0.rc0.29.g47ce80527c56
>


