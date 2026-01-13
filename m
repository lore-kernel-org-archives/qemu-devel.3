Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4096D2F33E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfhIf-0008LG-87; Tue, 13 Jan 2026 11:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfhIK-00085W-BN
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:31:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfhII-0000RQ-8E
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768321856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=boQE4q0KM6aYzkUDuqPLA1uwKPn46HvgGbqZIDctbEE=;
 b=VUvmtaQ5ybPMc7rF3S/EJrYdZo2P+NdiC4RkG9PRX1VA6b7Jkip7ia8IZO3skn8oDesxYi
 O1MrBFYZ4JXHsiIM3qQIuJ6y2bJVHr22CaobdglCajU3RDqmt1ZS3z6AMi7NyoSzP7c5R3
 VtWppBVt3lEVgm9t1t6mt/iXI8Ugl/g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-yKClN5DnO9WB4OjpsaMvuA-1; Tue, 13 Jan 2026 11:30:55 -0500
X-MC-Unique: yKClN5DnO9WB4OjpsaMvuA-1
X-Mimecast-MFC-AGG-ID: yKClN5DnO9WB4OjpsaMvuA_1768321854
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8bbe16e0a34so1917033185a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768321854; x=1768926654; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=boQE4q0KM6aYzkUDuqPLA1uwKPn46HvgGbqZIDctbEE=;
 b=NhWZcaf+PQVQHKOlJZlGS4fTRcGPHOu1cI6bnOcrYfAjpDDq+8WDChTm3f0ri4BhjK
 1ygYYUlqIsyMmQ3sXwJWKF/KtMiY5AqDT0WXoWJzTxmTx2b8LXvjZeljt3ekEsrE/Rps
 kX+5sSpA0ZJ4pQu2x8MNbkEmy2saHWf49t5R+Y5EFxQqp5qW2Y7Zi1Al3TnzyIr+wWTc
 ydfs+qXbEHOCTeQdcqb7qArm6jFDKXaKtMYdatbxRWQPyztuJp3Uxq6w0aLGAzhauy//
 2gj6S2cfHypdClZl7E4873uNZFol8Epjt5LwmwwVVdZtRy2Y+ZWvEHnRqD+yqdnO/uys
 XEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768321854; x=1768926654;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=boQE4q0KM6aYzkUDuqPLA1uwKPn46HvgGbqZIDctbEE=;
 b=GvUeGQizs+sWgZEmjWvA7putSQqzClqNGgewu/0cf9PLQnt6zhV5Y5biFw3jH/KcRW
 VaYa2+wkEyPRe3EOqrNDTzW5pw10+0kzbaOSjwYrOIW69bBKcaT76//0IHQET+vuvx/H
 27H8lrekS5hDmYHlulHqs02z3a7M/OCMK0vcOQaVB2i96hljNsp3Qf3uQ3sIzRl6oRdv
 Yb56ND9RHZ5DmWEwinbyZAGpSvjSzrQHeW3GEAVO1g3GwoXUWksf+Pev6dXtq0MUbPEU
 ixhGn+xRkHvpbFLJ8IaxxH+6yfenTOOnj03IyjFU0EyYjceZmtY7ef3cfEra7UugsE6n
 MY0Q==
X-Gm-Message-State: AOJu0YzQQDNjDgMvjeYTporqYaDlu7ofTjUGmEty+Dq4sExiJI/mjigX
 XkGXZ9KtzwDSlWbZplAh51RXtKIh+wgArS88cL6NRGw7z4gsBs6lIGlDEAdC7v13ck38ypnO36o
 e7Cgu1e5DBV7Tlfg3SVbsk2tq5Z179OHfueHypS6mbWYB+hL6vpLvc9xo
X-Gm-Gg: AY/fxX6nLB4/sUziBrmdMcX4nDpMQW/ZSOZs8WpB3N8H8XMqr/gR2SlquUOrYdi6N7h
 rpQuXiig91q7ymgZiH/SXw8SKKZU//WGHbE23lpvNFfiAI8Y1ekWGBZ1Z6OrOxparW68QbLTz5+
 X6RBMkmryhwQ+cl4G6RLrbwmxxh+3Fm3h0AaRr/K70q43kSQvELNxBU+xeXsfZ4idsEossqY2Iv
 uKw47Su/HHx+OQBuK0HOc9TaN26n/TvfxYTz019kmGlXn75i5WAiPT4skLjfzAARiC5nfw52kPs
 QB6wpmNqTmb+ZHizZGO0++FzMe+PPxr333irVe5EZOjecyWHeXhLWJsBpcx7GRBD31ua17d21py
 Tvis=
X-Received: by 2002:a05:620a:1a13:b0:8b2:ea3f:2fa4 with SMTP id
 af79cd13be357-8c52082ba2cmr467695385a.6.1768321854372; 
 Tue, 13 Jan 2026 08:30:54 -0800 (PST)
X-Received: by 2002:a05:620a:1a13:b0:8b2:ea3f:2fa4 with SMTP id
 af79cd13be357-8c52082ba2cmr467686585a.6.1768321853745; 
 Tue, 13 Jan 2026 08:30:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077267e14sm160158686d6.49.2026.01.13.08.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:30:53 -0800 (PST)
Date: Tue, 13 Jan 2026 11:30:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>, Fabiano Rosas <farosas@suse.de>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aWZzOz9hlvdRDj13@x1.local>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <aWZk7udMufaXPw-E@x1.local>
 <CAJSP0QVm41jSCma73sef7uzgEnqESRfqrxRstNTY_pd4Dk-JXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QVm41jSCma73sef7uzgEnqESRfqrxRstNTY_pd4Dk-JXA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 11:16:27AM -0500, Stefan Hajnoczi wrote:
> On Tue, Jan 13, 2026 at 10:30 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> > > Dear QEMU and KVM communities,
> > > QEMU will apply for the Google Summer of Code internship
> > > program again this year. Regular contributors can submit project
> > > ideas that they'd like to mentor by replying to this email by
> > > January 30th.
> >
> > There's one idea from migration side that should be self-contained, please
> > evaluate if this suites for the application.
> >
> > I copied Marco who might be interested on such project too at least from an
> > user perspective on fuzzing [1].
> >
> > [1] https://lore.kernel.org/all/193e5a-681dfa80-3af-701c0f80@227192887/
> >
> > Thanks,
> 
> I have edited the project description to make it easier for newcomers
> to understand and added a link to mapped-ram.rst:
> https://wiki.qemu.org/Google_Summer_of_Code_2026#Fast_Snapshot_Load
> 
> Feel free to edit the project idea on the wiki.

Looks good, thanks Stefan.

-- 
Peter Xu


