Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73BEC2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDTm-0002jo-DE; Mon, 17 Jun 2024 10:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJDTl-0002gy-2x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJDTj-0006Jb-4I
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718635021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDrJAc5UvorFitqOd567elICCjQt8v3IQBPi5lXIgac=;
 b=Z2telOlS+t3ABkrNDj8XFJ4qbbyVuq7h/REmIa4uUjmCB4xud9qQIwwAbIYsjqtSnAwxQr
 HJRx7daOxX+5QGFSk57GGCbE2o+By/xv6IDWdZZBGbYagI8s30gZqDAVq1NC3Rc/OSCmO9
 VakoXCL86XNozaPMOY2TBnLyL1a5b/4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-9gmlQZkiMiqM7UUz8xSThA-1; Mon, 17 Jun 2024 10:37:00 -0400
X-MC-Unique: 9gmlQZkiMiqM7UUz8xSThA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f2030f868so3213445f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635019; x=1719239819;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDrJAc5UvorFitqOd567elICCjQt8v3IQBPi5lXIgac=;
 b=oQAlYi4PcB/BgpAa734qkU6lMG+eo84kKvY1lPNOqUayxYe1nArKK0Ox3GJ/F/yjiz
 CdlcT1yp6wyD7qlhBJ2Nyz7v8b0V6BdU5NORufCUIZ7gqwDypa3ZrmpCJzOoHdPa59ch
 NvjxtrYwGeLI4o4kVZcdWoYAnOPDdmfm9cJjL+uFXea9eE9GH0f2AqofcPPCwICowFY+
 zGhcHfWsAfQAyvNUCZU50pQ4U+BEBcC2ktawjuyWMUNOzuyeu4tQaVtjSODAd47EkdJP
 oYXGk0CvgfjM0nlG/m7/eXECRrT5I63vvemWvYfcnX/RzYpYFQ8/D3aY7aiKuuHxK4Zz
 e4zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlye5j2FqjZ26CZvd8iRSa9bEEZLSz9kC4DEhoL0ZuAMCOLJdYiVmKn1hvU9QjcU2LTqtH0vwebPijyL311Xs3zmzvVaA=
X-Gm-Message-State: AOJu0YwSeTtYqSVBv8tiKwq6zf5/8i3C65tlid6KzNRpRC/Uzd/exr6e
 ynWFloMX2ZbS9GyYSnU8lEg/njgrxGpwHQljnrrVOdXFQZh8YGJnloLC0EkKETPjBH32Zt8srB7
 K2VItfLIGMn1JvPoix7SDel8LXfxaV21sDvtdaO7nXGFWf/blP9Bk
X-Received: by 2002:adf:dd8d:0:b0:35f:b3de:e24 with SMTP id
 ffacd0b85a97d-3607a7889d7mr9023936f8f.68.1718635019046; 
 Mon, 17 Jun 2024 07:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiEUtuhtb8evHy0u4AskxXLvQlkXKGaONu7pSnHSpQu+mZDcT6+1dE24G5EonFJqjWTgL88A==
X-Received: by 2002:adf:dd8d:0:b0:35f:b3de:e24 with SMTP id
 ffacd0b85a97d-3607a7889d7mr9023903f8f.68.1718635018720; 
 Mon, 17 Jun 2024 07:36:58 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.177.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42301a7c850sm154399555e9.6.2024.06.17.07.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:36:58 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:36:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 slp@redhat.com, 
 Igor Mammedov <imammedo@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 00/12] vhost-user: support any POSIX system
 (tested on macOS, FreeBSD, OpenBSD)
Message-ID: <vabzv4z6g3dd5yndvpmwktcfgbqrdg7qk2e5se6zuflrhss723@dws4vrzen6cs>
References: <20240612130140.63004-1-sgarzare@redhat.com>
 <rx5hvcffqzmixgmlroko7t6qvjciifr77nvpwrakpl5oovw3ec@mihi4k5nhse6>
 <87iky7eq09.fsf@pond.sub.org>
 <ngknr5yzaqso2aaw3baxq5sa4syo36igyk63lcvymjbtu3eqos@aolclgpjy2cy>
 <20240617094203-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240617094203-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jun 17, 2024 at 09:42:21AM GMT, Michael S. Tsirkin wrote:
>On Mon, Jun 17, 2024 at 02:59:14PM +0200, Stefano Garzarella wrote:
>> On Mon, Jun 17, 2024 at 02:02:30PM GMT, Markus Armbruster wrote:
>> > Stefano Garzarella <sgarzare@redhat.com> writes:
>> >
>> > > Hi Michael,
>> > >
>> > > On Wed, Jun 12, 2024 at 03:01:28PM GMT, Stefano Garzarella wrote:
>> > > > This series should be in a good shape, in which tree should we queue it?
>> > > > @Micheal would your tree be okay?
>> > >
>> > > Markus suggested a small change to patch 10, so do you want me to resend the whole series, or is it okay to resend just the last 3 patches (which are also the ones that depend on the other patch queued by Markus)?
>> >
>> > I guess you mean
>> >
>> >    [PATCH v2] qapi: clarify that the default is backend dependent
>> >    Message-ID: <20240611130231.83152-1-sgarzare@redhat.com>
>>
>> Yep!
>>
>> >
>> > > In the last case I would ask you to queue up the first 9 patches of this series if that is okay with you.
>> >
>> > Michael, feel free to merge the patch I queued.
>> >
>>
>> I can also include it in v8 if it helps.
>>
>> Thanks,
>> Stefano
>
>
>If I'm to merge it, pls do.
>Much less error prone.

Okay, I'll include it in v8.
I'll wait until tomorrow to see if there's any objection on the tree, 
but I think yours is the most suitable.

Thanks,
Stefano


