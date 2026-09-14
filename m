Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1D1C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68Cw-0000c3-0s; Mon, 14 Sep 2026 11:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x68Cl-0000ZX-FT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x68Cj-0007IP-DS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789398161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsH+oxYwijmpnAjB8UTk0Ua0iNkmD9AVfjPmwAIMIbM=;
 b=LlMX90t7kZaxWS2cHirXliUupUi+EkHHWEUOuO0E5oBJGR9tHxqB/seGUl4sN7fkWOmfjl
 w2smgm6p7wioJdKrRmNOW3fkKNYbVGM5NIuzg3BKU+u1iSCVn9O3ykNRgfYnaZ7nTpnuPq
 g+4U4CaQ/RvZajXsonhal+5qxaNfBSY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-8SjwNhbCNG-WkM1Ur0fetQ-1; Mon, 14 Sep 2026 11:02:39 -0400
X-MC-Unique: 8SjwNhbCNG-WkM1Ur0fetQ-1
X-Mimecast-MFC-AGG-ID: 8SjwNhbCNG-WkM1Ur0fetQ_1789398158
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b8088202so2930158a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789398158; cv=none;
 d=google.com; s=arc-20260327;
 b=jUCuXTkHBqJ30Qa/Lqt0AZRdUvQynvkUnD3hOmKRujC0AhqS3SxDEZOQJIPSGf6Pd9
 Que/a3HqQyygqUohBqXDkoo71vOav/TpuhWtL/6hUQ60Efczu1o9zRGNYLD+jMr7/J6C
 s7Hh0hjVe0bNJq36SUkX6QegNsKAkTSfVvCPSMRAbNew4YNkc9oCibcPoNowtEsg7cy0
 xijiF7caCt5a+liKCzx5bweM13QvIVzzgLUKt58DVzfDpA+v8PIFFXB2Z9wFQgXXQB0c
 pHCwg94WdkZc8RoAbjXnlEhHuSkG3KL4o1Mf8TWcxbIX3SzeKA4laoMRZ0M76qufw7yZ
 BYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OsH+oxYwijmpnAjB8UTk0Ua0iNkmD9AVfjPmwAIMIbM=;
 fh=Rv6Xr49Vn3lqTFaNl5Jkv/KgdC6v9IqnBD35t3uum7E=;
 b=QmMH0PC9BoBhfGnEcQmaS3HkjX3mpKEt0FdZx+KWobMmtE1HwVc+jr1A4f0+7P2TDy
 IcpyDsnq8+LgE1Bik8OIEH4YXQBASCitHUOmbmfJon9geE0GrBxjEyxcmB1thwEg2OnE
 OnoZbEoaFByD3NKIbOjIR1AwOn5ARcyOzGp6d7D9eXJlN9qcmXku/QglTKqQlTtPyjwV
 R4V2YRDUpI+Vj+utA3I1vOf4W0PQuV3rodnCsLXRp8MimOaCmPdjNMfEos0ccbQytHie
 5S3039iiUBVr1SmqaBHmk2YjnavjNxqTL2DJkVJusmLLQAXk2trZBJkloRgDd4Jr+D5H
 9U1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789398158; x=1790002958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OsH+oxYwijmpnAjB8UTk0Ua0iNkmD9AVfjPmwAIMIbM=;
 b=bVbpkQSoyHWmx+/ZxFQMlTz5js08F4Ge4PCbcK5LUl5RcD0vZvLDUJQpqGTJw6OUd9
 tJaGiF/RCh4ByLo6uAA7Deq8Ti7iuVFHDufC2FHa0Oal/uS8Btb/nJeITzoTSzVolDxQ
 tAieyM4b2fwWdPjMIpz1UlUycGs7B4u4T6JMNhiHVYnZJ71glHDRvDL54dUholI1jFu2
 k9H9MHkSGCfPWFpGsyhS3kQckE7NiFLgNskL7KGwwN24P27USVo1oLAcKriOg63ZQ1OE
 Ts0VBQ2wNwfkfnvzBJS6Y/OB1V88LokTqmvdsd6rHFjlsk1q8wL0q/E/vJJ7auNS5H0s
 0egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789398158; x=1790002958;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OsH+oxYwijmpnAjB8UTk0Ua0iNkmD9AVfjPmwAIMIbM=;
 b=PvU92Gm/RJajjcywF4S1cX18FS7ro/tDyJKjDTU/JWiOqQR1qv4XMPeqo245hXv5Df
 ytYrDA4YNS3r6g+nhkjohHyICX0CIOvUQeRmbGkVsHxfwAkYoRPF6GdRKFJg2okfQCnV
 lF6eDZSepNNLfIg9Qa4BQEEzO4194Tsos7mMT8px7RgOxT82wPbKOQLJ1z7oE0u4n1G8
 MdZHydpWTTNqqCEte4zUbPNXifxYNcvWtZzsDM0l65wSqRE9cNYu6PrQj6PX89xXddXe
 JWybYHJks778viwdPlTL0JXEznXc9KfGwxqDdJiSrOTWzuZRyTWWXBFsI64RtXK8rTo0
 WDgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSNoLcu+UQDEaDrf8vbAsmm8USB0nlb9nWHL7jA2Oof90TVD0w+vh5yEpjlC8OR2YDpm9pSV3oKwVG@nongnu.org
X-Gm-Message-State: AFuF++l52xZExc6QSeot1l6ZZrYtMt78aPJIgCwJbUKU75TydXJcSWge
 pk67ZFxRnus1GwRw/aYQzxPnOPeqDh10J6SYIahYet4hzjZX+j1tp/4TIqOFGTmHwbmWjxiIQPz
 Hmi0loNt8VeO3lzO8ID3IU7IM42zGb48gANGY7xpCApEk0mBJGUOnx7+oH8ynY5t6ZhwvHrSeQo
 dRVQrbPRATIkJbK29Z7iIpRma7Ku4wRcM=
X-Gm-Gg: AYBFou1whf1SvMYvM+TxG0zg7vpobCGnb3Mj1zW6DWvMi03BSkGNQWE+yyKu2DvQwE0
 Aecg9Ck9CMS0O2adggP25qv0si3N2p0J4NBSFZEJ8bNtmx7U8d6mZzpbTuI8iilxXNOV+FS880e
 MJDw3BFr3d47AfGQNKXJwckAhTlpu2V0b9kdSZlSxnO7bXffkzjX8dlGnnogM/aJCuxkSuMvfXM
 uP6YVJ/AKaAE3sQ6Xpfo+36W6yKVYNwC80sGw3Y+brxEr7FNlvVzKyyTHHmbzWW7x6GLnRqf2xo
 Ig==
X-Received: by 2002:a17:90b:2885:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39dec0849e5mr7257199a91.18.1789398158263; 
 Mon, 14 Sep 2026 08:02:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2885:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39dec0849e5mr7257076a91.18.1789398157695; Mon, 14 Sep 2026
 08:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
 <20260907075640-mutt-send-email-mst@kernel.org>
 <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
 <20260907093319-mutt-send-email-mst@kernel.org>
 <CAJ+F1CKiUFGqJbWuxNM54bPJg1AicBKK_i+AuXttSCy-JRr8xg@mail.gmail.com>
 <20260907152927-mutt-send-email-mst@kernel.org>
 <85f8ffaa-f888-416c-beba-0344ceb8bf3d@yodel.dev>
In-Reply-To: <85f8ffaa-f888-416c-beba-0344ceb8bf3d@yodel.dev>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Sep 2026 19:02:24 +0400
X-Gm-Features: AcwNN1XT8sCO27z_Qtb1fGx5-7JVeItkrqPiHjL7q9Si3hgagpHC6XPVe33T-Ek
Message-ID: <CAMxuvazm00i=9Kj__0Otx96FCKnkebYqED50eiTS7D9ikYkz9Q@mail.gmail.com>
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
To: Yodel Eldar <yodel.eldar@yodel.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi

On Mon, Sep 14, 2026 at 7:00=E2=80=AFPM Yodel Eldar <yodel.eldar@yodel.dev>=
 wrote:
>
> Hi, Marc-Andr=C3=A9 and Michael
>
> On 07/09/2026 14:32, Michael S. Tsirkin wrote:
> > On Mon, Sep 07, 2026 at 06:18:39PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi
> >>
> >> On Mon, Sep 7, 2026 at 5:35=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >>>
> >>> On Mon, Sep 07, 2026 at 05:22:43PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> >>>>> maybe just avoid stdbuf completely.
> >>>>> i don't remember why we use it, but it looks like merely to
> >>>>> disable buffering for stdout?
> >>>>>
> >>>>> If so:
> >>>>>
> >>>>> setvbuf(stdout, NULL, _IONBF, 0);
> >>>>>
> >>>>> will do just that with no asan issues.
> >>>>>
> >>>>
> >>>> That requires modifying vhost-user-bridge, not sure that's what we w=
ant.
> >>>>
> >>>> thanks
> >>>
> >>> why not? it's not like it's a facility useful outside of testing qemu=
.
> >>> If we were we'd probably disable stdout printout completely.
> >>
> >> Since the test redirects stderr to stdout, I guess the log is
> >> fully-buffered for stdout and unbuffered for stderr, and we see stderr
> >> log lines in the file log before the others. If we call
> >> setvbuf(stdout, NULL, _IONBF, 0) early, we probably will get
> >> interleaved stream output, but probably broken lines...
> >
> > We can also just change that macro to write to stderr.
> >
> >> Tbh, I don't
> >> have much motivation to check or fix this, I would just like the test
> >> to be green or skipped when built with ASAN. The current workaround is
> >> quite ok. If you prefer setvbuf() in vhost-user-bridge.c, I am okay
> >> too.
> >>
> >> Yodel, wdyt?
> >
>
> Apologies for the delayed response, and thanks for finding,
> reporting, and addressing the problematic interaction
> between stdbuf and ASAN.
>
> I have implemented Michael's suggestion to modify the DPRINT
> macro to write to stderr and can attest that the log lines
> are properly interleaved even in the absence of stdbuf.
>
> If there are no objections, I'll submit the patch shortly.
> Below is a preview.
>

Yes please, thanks!
> Thanks,
> Yodel
>
> -- >8 --
>
> diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c
> b/contrib/vhost-user-bridge/vhost-user-bridge.c
> index 3f0fd0fa49..a6f7ec226c 100644
> --- a/contrib/vhost-user-bridge/vhost-user-bridge.c
> +++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
> @@ -41,7 +41,7 @@
>   #define DPRINT(...) \
>       do { \
>           if (VHOST_USER_BRIDGE_DEBUG) { \
> -            printf(__VA_ARGS__); \
> +            fprintf(stderr, __VA_ARGS__); \
>           } \
>       } while (0)
>
> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py
> b/tests/functional/x86_64/test_vhost_user_bridge.py
> index c36c625420..5e1db48884 100755
> --- a/tests/functional/x86_64/test_vhost_user_bridge.py
> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> @@ -76,12 +76,6 @@ def configure_vm(self, ud_socket_path, lport, rport,
> hostfwd_port, tftpdir):
>       def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rpor=
t):
>           vubr_args =3D []
>
> -        if (stdbuf_path :=3D which("stdbuf")) is None:
> -            self.log.info("Could not find stdbuf: vhost-user-bridge "
> -                          "log lines may appear out of order")
> -        else:
> -            vubr_args +=3D [stdbuf_path, "-o0", "-e0"]
> -
>           vubr_args +=3D [vubr_path, "-u", f"{ud_socket_path}",
>                         "-l", f"127.0.0.1:{lport}", "-r",
> f"127.0.0.1:{rport}"]
>


