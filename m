Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213C9FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI0K4-0002wi-96; Wed, 29 Apr 2026 04:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI0Ju-0002vm-LL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wI0Js-0006aD-HM
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 04:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777451452;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1NrbY0h6p9/tm9rAzoaLseHsXWtV+Uu+ajF0aU9JQRw=;
 b=dyUCAxis54N7MRkWRPVnHWRQ6nnzinHOodu62XJz9eShfJ0fjUivr3/Gyb/jhK5GKWDDrv
 gCx+naenExpEFHOlrLuQamza3KRJrvQBZjsFL7mo/m9HA/fygCHus+dxIcrTSjeq3mxEIB
 LbsphilYPF1NO7OcJzAvzzjPdLpiG+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-egs0DmJaM02FOU-vfZ1JjA-1; Wed, 29 Apr 2026 04:30:51 -0400
X-MC-Unique: egs0DmJaM02FOU-vfZ1JjA-1
X-Mimecast-MFC-AGG-ID: egs0DmJaM02FOU-vfZ1JjA_1777451450
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-440d12a472eso9108397f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 01:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777451450; x=1778056250; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1NrbY0h6p9/tm9rAzoaLseHsXWtV+Uu+ajF0aU9JQRw=;
 b=BPFdN4yE7UBJK6SA/mYkKHgLNhNdx728WWLxJw1p+Zm1fAXeK+eW/nlRlyYCFRekGU
 GvNAf71eBuflDKkl0FSrMVzol/L7SAHOfmSvuSUvqYmrSKu+2RtmaItHUYLnjOZuQ0AL
 4mstpAOKpYFf5k5g5ZwUn/to3OTOGUaixcsWZ1LDCG4tdrxN1Uwxcw8qCH6ZGiipxfWT
 ivzSlIXei3PI5mnOwM1qI5AKI43fpeRwxdR4YizA3PdeppbJEDv1y7IjFC4LmFNW0KE+
 w2bcN1pCKGqP4vfflwMEbIk4HE74LURidoCyFB164nuyU/ze1Z7ZhMyhr4jNaWoOwU43
 96iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777451450; x=1778056250;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:reply-to:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1NrbY0h6p9/tm9rAzoaLseHsXWtV+Uu+ajF0aU9JQRw=;
 b=cDtTNY8q6Ix05YpJOkkFel1FEhlykXKXEUq7hLprriGTVEr4hD1RLYtXz9jboM6eib
 ncrg8OJSIDKuR0aav3c3sqCxt2wAlIyMgakT2oclQfBuN8xtGbN6i0SpOFbBo0LKezwv
 97YPZxDKlnOCsw6IyfHaX+Sa/zSwyAew2JpZDlfOguKJEqWV8xxqTjNaoi1X78TaiNVi
 j4lxHzXi9XOALXuqPuqSYU7yeTgWmZdmuS6pgX/0XsnR4jd+FmO+a1iGUMSJNtUubYrI
 XJLCbOyEGHOe0mC+d6jiix+EardlLb2gapXa1AQRrWa96wy+c5zvN1QOBRaGYTqzf/q5
 8lfA==
X-Gm-Message-State: AOJu0YxUI4JdNBh/1CEMnvZK6z1VD/Mjvr7qlwc8NPC0jFRSgnmvn7Gn
 sAzNxrNdNCLZ6qAxbOOgn265f/aEpqtkuXqUfK0IRkRgwKcQMVOlWZdZeg+G7NQgUSe1pPX+FX8
 rYrXG2dBAzgRvySrczQ7Q8oZ2Nb3pFDBdzmC50/uke4zMtMvUEn/fiOZh
X-Gm-Gg: AeBDievXb18pd9b4r+lsBZYHeKWozPOdfRC6VF34zOewxyJU8l6ZG3x6b8xHh3AV/dj
 cSTyiWuwjL4PtwZ06RciwJdaX63zWQ5SEUmm8wK6a1lcPrJjUPUFjhwtMJcah2Px6DqWmmowBwv
 V5Hxcaf+R257tNsX8n1dhtz0vG/eWmjzbaU7IjTONnfzO6kgsR3GmroRMgyeZBzl3Rb7StyspRI
 8vFR++yDeEVZDXxesHeiV7rDa3EZ8THhY7QloJOMu/zxqtxTqf4Nrpijlfy5lgvMbQtBCr4yqa0
 X+HY6FKjoghDCWzu4Ch56L5PUhif9xjnWSaNy4zW97PDf5PsuDtFMSaGM9KDv+jdOdqu6HoE/OF
 ewt2pTwsyQ9NMt5HHqC6x1rOU9jnvwjw=
X-Received: by 2002:a05:6000:3107:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-44648963af5mr11733176f8f.20.1777451449688; 
 Wed, 29 Apr 2026 01:30:49 -0700 (PDT)
X-Received: by 2002:a05:6000:3107:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-44648963af5mr11733099f8f.20.1777451449029; 
 Wed, 29 Apr 2026 01:30:49 -0700 (PDT)
Received: from redhat.com ([2a02:8012:f011:0:f1ce:ac56:d2cd:7c2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b3d47ff1sm4260511f8f.6.2026.04.29.01.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:30:48 -0700 (PDT)
Date: Wed, 29 Apr 2026 09:30:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/67] ui/console-vc: add UTF-8 input decoding with
 CP437 rendering
Message-ID: <afHBtmEr4tWPgZyC@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-9-231416f76dc3@redhat.com>
 <ad91dIuoiLOdIHHN@redhat.com>
 <CAMxuvaxw3mBdhE24dT+CrBhVtvosQYzMEt3f-gGdtvwj4Ce3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaxw3mBdhE24dT+CrBhVtvosQYzMEt3f-gGdtvwj4Ce3qg@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 20, 2026 at 11:54:40AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Apr 15, 2026 at 3:24 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Apr 10, 2026 at 11:18:31PM +0400, Marc-André Lureau wrote:
> > > The text console receives bytes that may be UTF-8 encoded (e.g. from
> > > a guest running a modern distro), but currently treats each byte as a
> > > raw character index into the VGA/CP437 font, producing garbled output
> > > for any multi-byte sequence.
> >
> > Presumably the key words here are  "may be" .... as in, it
> > also "may NOT be" UTF-8.
> >
> > IIUC, the current code is assuming that all data from the guest
> > is in the CP437 encoding (8-bit Extended ASCII), and that encoding
> > has valid characters for all 256 code points.
> >
> > By adding UTF-8 decoding for val > 0x80 this is breaking compat
> > with any guest that is outputting data with the full range of
> > CP437.
> >
> > IOW, this patch is moving the brokeness from guests which
> > use UTF8, onto guests which use CP437.
> >
> > Only guests which strictly limit themselves to 7-bit ASCII
> > are unaffected.
> >
> > I accept the UTF8 should probably be considered the common
> > case for modern guests, but this hardcoding a different type
> > of breakage feels undesirable to me.
> >
> > Surely we need an explicit config property here to select
> > the between character sets we expect from the guest ?
> 
> Probably, I don't know if many guest/apps rely on the serial encoding,
> but we should probably be conservative.
> 
> Adjusting the decoding at runtime may be possible, but it could be tricky.
> 
> Instead, we could add a vc chardev option like charset=cp437/utf8.
> 
> What should be the default? For compatibility reasons, use CP437 for
> pc machine <=11.0 and default to utf8 for others? wdyt?

Strictly speaking this is not guest ABI, just a change in defaults
for the backend. So as long as we provide the config option, we could
potentially just change the default to UTF8 unconditionally, on the
basis that UTF8 has been the default charset in mainstream Linux for
20 years. Not sure what Windows uses by default, but use of the serial
console with Linux guests is much more likely than Windows guests IMHO.


