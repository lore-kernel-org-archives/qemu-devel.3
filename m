Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42971C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 13:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4gvL-0003il-7q; Wed, 08 May 2024 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4gul-0003Sz-Gk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4guj-0005HN-5I
 for qemu-devel@nongnu.org; Wed, 08 May 2024 09:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715173251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hOGAgJ8kVeI7/gi4mu8fpO+xHHgVmxDX+ubOjLaVUc=;
 b=YHxi6A/nMFmcWiiXTwz7fRtjSR02hfKl8XV9Gw8vxKCy6H6t75XSUe1ZivHR/IqHZpXojb
 UnJBWLK38QpCFs/qzSgZ5RaOv2AclMlZRY5cY6FzTCw3iUqLhrhgzYv3xPOm1fYcUG2JYP
 VYRJB15eRXK5YGdaKRk/UHIrIFjOoLs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-xjt2EiI6O4ygkTw2YwHtrw-1; Wed, 08 May 2024 09:00:46 -0400
X-MC-Unique: xjt2EiI6O4ygkTw2YwHtrw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34eb54c888cso4241403f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 06:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715173245; x=1715778045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hOGAgJ8kVeI7/gi4mu8fpO+xHHgVmxDX+ubOjLaVUc=;
 b=Asmo/NRLYQXzVOYYhsVaKfOuFsA+tF67OLu5RklwV89mR5OPPfGBhq3viD76xIm4rX
 CIkZyBfeU071I1yBjepS0vSCmHvUguiv2eyRmSibvHfXgrY1eqPo8LqOLv2VSa14/TBQ
 GVtV8JB5jxw1tRROQdMehVO3zO6KBOiAhdFSjodd6ibeWtP94c95GvRQpnP4PCN4Rec/
 W+tUF0407Vf8UVKulbIUYIYMxg+7z7ItcbXIIoTd8wfV7kfX9ItHS4jxpIr2Xq2ssFbg
 De+xKCzxYaCcs6YAlyQ88Q7W34705aVeoEV62rNQJP9eIUORupr7KwavlVmM+AHaElm6
 PEGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1bJE6svN9TF6KlnYO8oPMSGu8kqj5ZIy/NrYEpo5J20XeF7sueVT6dYl43pfNoB2k9yiEPOWsEuAgbk+rdXp1Hb0+A0s=
X-Gm-Message-State: AOJu0Yye1mFHk/HPySP34XfKYdXCp+l/hgl16XOp1XESXPxzS2Bb7TcC
 L5NA/KNPP49bdfdguwe62EH4SZDMfzdYCCEEIdMTXNk+9OzGAhcsGUI5JrSU40d5lGWBEOkRIcJ
 ockHsFChZ15vGyYNSj1G+oZZciaURz40Hi12SEwzoAVII0zdexy09RL2ZOT/o1zl1nB7Cyx31pf
 uDIc0/Tw1ZtBQQL248F9G4ZYHgcUo=
X-Received: by 2002:a05:6000:146:b0:34d:a7bc:e647 with SMTP id
 ffacd0b85a97d-34fca80df7cmr2608689f8f.62.1715173244252; 
 Wed, 08 May 2024 06:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKsjLGwL+mkKTd9Y+RqaOVwzDGYjU9iaVZz3Ct56pwT5al2Ur5nly6FWL6v9yninU93jsGAQXiu043zMimxQE=
X-Received: by 2002:a05:6000:146:b0:34d:a7bc:e647 with SMTP id
 ffacd0b85a97d-34fca80df7cmr2608642f8f.62.1715173243563; Wed, 08 May 2024
 06:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
 <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
 <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
 <5o3xyylget6hqhdaya5cj5tnbmmpzxk6u53cp6jhpviev6ez4m@ri6ady5zc6n3>
 <30baeb56-64d2-4ea3-8e53-6a5c50999979@redhat.com>
 <Zjt1VdKQ3KIZChg9@redhat.com>
In-Reply-To: <Zjt1VdKQ3KIZChg9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 8 May 2024 15:00:30 +0200
Message-ID: <CABgObfb8o3L_FawdwFX7Ow-+LN7wyGbvSLWubJrpyTgH3uo-uQ@mail.gmail.com>
Subject: Re: Hermetic virtio-vsock in QEMU
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 Roman Kiryanov <rkir@google.com>, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, 
 QEMU Developers <qemu-devel@nongnu.org>, JP Cottin <jpcottin@google.com>, 
 Erwin Jansen <jansene@google.com>, Mehdi Alizadeh <mett@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 8, 2024 at 2:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> Designwise, a native VSOCK backend in QEMU really should implement the
> same approach defined by firecracker, so that we have interoperability
> with systemd, firecracker and cloud-hypervisor. See
>
>   https://gitlab.com/qemu-project/qemu/-/issues/2095
>   https://github.com/firecracker-microvm/firecracker/blob/main/docs/vsock=
.md#firecracker-virtio-vsock-design
>
> This involves multiple UNIX sockets on the host
>
>   1 * /some/path   - QEMU listens on this, and accepts connections
>                      from other host processes. The client sends
>                      "PORT <num>" to indicate that guest port it
>                      is connecting to
>
>   n * /some/path_$PORT - QEMU connect to this for outgoing connections
>                          from the guest. Other host processes need
>                          to listen on whatever path_$PORT need to be
>                          serviced

The former is quite horrible, but okay. Out of curiosity, which
clients are using that convention?

> IOW, from a CLI pov, QEMU should need nothing more than
>
>     -object vsock-forward,prefix=3D/some/path

I would call this a "vsock-namespace" object with a matching namespace
property on the virtio-vsock device.  The id on the vsock-namespace
object would also allow 1) adding vsock-forward objects hanging from
the namespace 2) omitting the prefix to only allow specifying
connections via vsock-forward.

I agree that allowing interoperability with existing implementations
is nice to have, at least as a principle.

Paolo


