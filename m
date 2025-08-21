Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B5CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5fY-0003Ce-Tj; Thu, 21 Aug 2025 09:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up5fV-0003B8-WC
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up5fT-0001MH-Jn
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755784166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCuE9avvXSYo5aEE6qxecyDsEbW2wP+S8MoxLSQCKp4=;
 b=W6Ip5nYFbvOO/GnrGGPHggJcAXXzxDRF2KbI9d/ps5opAvhCIGLKuOL5PnUIRvENpkZz69
 Lc/+s/wRgc3PhFviQjeyQQAazl3Q89c8OyH264dOXfINfcvfjS2N3fOZaZxj5uB2DTtCrg
 8N6nYtwXUa7qsO4VJQMR6HNPxQs1QGo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-VJ5y8KKwOrytFK7CnXnTqA-1; Thu, 21 Aug 2025 09:49:22 -0400
X-MC-Unique: VJ5y8KKwOrytFK7CnXnTqA-1
X-Mimecast-MFC-AGG-ID: VJ5y8KKwOrytFK7CnXnTqA_1755784162
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a928dc378so23321656d6.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 06:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755784162; x=1756388962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCuE9avvXSYo5aEE6qxecyDsEbW2wP+S8MoxLSQCKp4=;
 b=PWCfs8r3idO+WtxWvFgaU+OOOIQT6ufFKSTApHHjDL2puJnjpnQIS/rfnatm8a6ptF
 OJiX9O8DyPj6KYOtBLNda3G+nIe5eBQiayrODG/hIS/m350JoZs1WZsdXkbeO75LfvuX
 0937811eM7OXJQHHadUBnCOj0VDXS7ilyw5wcR/0YD7qUWyw1QLJW5ZyrQm65Nwcgxnz
 CLV61gAGa7w+epXxHTWbiWsq3Qs/iHFT2j++rztvDZcFaXgY1a6R+4IkAtFB03f8W6uP
 Y3+7zCDFzanSofeA/N0HBfS7m6Sgi++2Z2km5agdsXLIcCXgwqXaDErtt+R/cqxhu6sL
 9rhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWflD3SD0159vCYqxR7/6dj+kH9ANsu0Eo54GOj9sFGxqsoBQjKp+LT3r8h3XTN66Rtqtzk5G0hBlNq@nongnu.org
X-Gm-Message-State: AOJu0YxBhSqqeC6Z7QUkkvqTJcUOBIivXm5B9DbMLM2I6v0x0oLq7qrN
 Da435+bWgqFOPx4iUUBPR2BXjIfDSE0GrCQggLA7Uk5HnNYHGl+QQfQfHiTa2gN9aiPkXNZbBdt
 1rbBLkfVQDjbmSciqSHuQCTOsLA1shnLTer/ms1ooMU7aX3LGP3mjuBrt
X-Gm-Gg: ASbGncvivQKj+CHAzmN0ac9RGvQT+MZ9+QEyr/i27IQl9oZdDlPJ+GB7EKgKAIh7oc8
 eZZF4/o6xDiKx9T7K0aCkS+Wr/Au8KlCUwTFnHQlavDUlcZwOTg7pzo5Vxew+TEtu4L896xHKPg
 kKItOytEuux+fVBAc0g5fOi6yN1Z8BR1yEyblg0fij8V2UbNYkQG/tHM2FMMADDUdKR97GLob5h
 bmhJaCFkhmGsiIziUYtb/F5Q4KUfo/NJn2V46DTWl5UbTSYpzcThv01PrvY5BDyBJkQK8KtjNWi
 CcOjKPZoidqzpXMD9XO3e0MPbQlEtkPe
X-Received: by 2002:a05:6214:5017:b0:704:f396:913a with SMTP id
 6a1803df08f44-70d88f6bd8emr24392106d6.42.1755784162206; 
 Thu, 21 Aug 2025 06:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzwOYTFiw7eSMOsDLCyCYu8cDSM5YP43SovTB3WZUuafH6RNFaYSjcWtaKkUYxJMi8MvMYug==
X-Received: by 2002:a05:6214:5017:b0:704:f396:913a with SMTP id
 6a1803df08f44-70d88f6bd8emr24391856d6.42.1755784161804; 
 Thu, 21 Aug 2025 06:49:21 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba934cf82sm105123186d6.51.2025.08.21.06.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 06:49:21 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:49:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, farosas@suse.de, raphael@enfabrica.net,
 sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Subject: Re: [PATCH 27/33] migration/socket: keep fds non-block
Message-ID: <aKcj1coyywvbtW-h@x1.local>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-28-vsementsov@yandex-team.ru>
 <aKXN4bykrOFE6_cX@x1.local>
 <f52081b6-bb8b-4d2c-86f4-1c0b1fa5ac57@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f52081b6-bb8b-4d2c-86f4-1c0b1fa5ac57@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 21, 2025 at 03:15:24PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 20.08.25 16:30, Peter Xu wrote:
> > On Wed, Aug 13, 2025 at 07:48:48PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > For migration channel keep fds non-blocking property as is.
> > > It's needed for future local migration of fds.
> > 
> > It is pretty risky.  This changes the attribute for all the iochannels that
> > migration incoming side uses, including multifd / postcopy / ...
> 
> But for now nobody (except CPR-transfer) really pass fds through migration,
> and for CPR-transfer it's obviously better to preserve the state by default (see
> my answer in previous patch).
> 
> So I think, we are in a point, where we can chose the good default, and
> document it.
> 
> > 
> > I left comment in previous patch as a pure question trying to understand
> > whether the feature is needed.  If it is, here it might still be good to:
> > 
> >    - Above the line add a comment explaning why
> >    - Only apply it to whatever channel that matters.  In this case, IIUC
> >      only the main channel matters
> > 
> 
> I still think that preserving non-blocking flag "as is" is good default for migration,
> please look at my answer in previous patch. However, in this series I may adopt
> to any approach.

I also commented in the previous patch, let's see whether we can make it
not only the default for migration, but the default for iochannels (hence,
any chance to drop the new feature flag completely..).

If that won't fly, I think this is fine.  In that case, please explicitly
mention that it's intentional to change all iochannels that migration uses
in the commit message, and we can also add a comment inline explaining why
we set this default for all migration channels.

Thanks,

-- 
Peter Xu


