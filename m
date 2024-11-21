Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAC4D7879C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAnr-0001Ql-5u; Thu, 21 Nov 2024 12:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAno-0001PH-KU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEAnl-0004Du-Ny
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732209427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94xag3WfZU0LCRPD4b0IuYtnsrnjPOeflFMW1Hu+BMc=;
 b=UEsRU/K3r0WC2YRj32zDO30ZuGWosKSieu07F7DeaThgkYZH11X/eN59bqOYkmBHVk2W9l
 cGcI+NLxvjPf73wlHKhDfXFP8OEoDDExicP+HVNL2cuea17+A77PESVYreMfk8ziWpa8IF
 g++dJKyRVgTfrTxInRgRxnx6UZHhhWQ=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-pylotmSBMviIL9jl9l137g-1; Thu, 21 Nov 2024 12:17:06 -0500
X-MC-Unique: pylotmSBMviIL9jl9l137g-1
X-Mimecast-MFC-AGG-ID: pylotmSBMviIL9jl9l137g
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a78589df29so9276745ab.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 09:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732209425; x=1732814225;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=94xag3WfZU0LCRPD4b0IuYtnsrnjPOeflFMW1Hu+BMc=;
 b=B5NbN8yofOlbQk7QwZwC45o7SrDD9YII24fjlLyu6aiG7qtxiv7dB5rcqrYJOGTpUx
 fZoSBkI2zRew3+5JWoomW0W9k4bWgwNXXOxQjOkadsM7bn0Hbv2k2sawRqk7BAsK9x63
 ymi0UtBLRdRD3ZRT0We7M8VCSeumSQtZTsjJpl1IJA+YipCmDyWbNHYzz5KXrlQ3ObOA
 QrJgxds/KAZdKnswjJtpde1PMEiEMyvAdDzIivd6R7mx8sxWzk9Rfa6pqMZEg0cfC+w2
 EdDG5K4IU16pEu9JH5l36LOHQGd1poNNOLcVlTei6D9FzvC9B3JDocK6VUx3CzYAEdIj
 gPTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd+tsuJoi4XXafYcqCt2Q/dp6fuiVBirDhXEHRMSTZ//ld2hk+jaXfdpRI4PqJQkNUmpb7GIh6gRwp@nongnu.org
X-Gm-Message-State: AOJu0Ywd8aEAESvpIEHezq9V2/UhCQFbIowMik6OnnpVFqnoB5XDzihY
 G5AFJGKdkj9/dc90A9A6ZMwMmb/su79o5Fp/uczVhhmpGKdRVU6ZXlo4Sjy5QZ8ukV3Wv9kJGrH
 P5ONIqc/qNlKebJRX5WFx1xmZs4GPWjxtGk9iNhwxer9CCiwk3vEP
X-Gm-Gg: ASbGnctrY3D6ioik/Q6E4cR52F72Gi8xLuw6OHGuzytnvjsJ6xBppiPFvxWZmSVcLcp
 meUOcyXkz1s+NH+bcG7g6wjDpPznOmuQlmDaPLAbPyLLYBhO4jWiqMpwdUfIvRwIufnVRvwjSbR
 Yf/HXz+W1nNRT9bqbx0vvzm2sjsPj7cEmFruFPXIiBZluGF77XXCA7reEHfQsxtzwrCYDm/Fohn
 SoaS+dxTJsm23iTT35lrWly7+pdMKf+jznrnhZfo8BSitsirSTCIhGjFypE0WKMK/n8LKUCQeqg
 cZZ6QTQTE1w=
X-Received: by 2002:a05:6e02:1cad:b0:3a7:78bd:e486 with SMTP id
 e9e14a558f8ab-3a78640fbb7mr89792625ab.5.1732209425369; 
 Thu, 21 Nov 2024 09:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjJSUUrSMzJMXI32zrY24rbD8jn06vVYxmtZq/ogUG3MzVU3kXX0kYWAw2HE+eLhX3opOr/g==
X-Received: by 2002:a05:6e02:1cad:b0:3a7:78bd:e486 with SMTP id
 e9e14a558f8ab-3a78640fbb7mr89791935ab.5.1732209424840; 
 Thu, 21 Nov 2024 09:17:04 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a74c7bcff1sm35354925ab.74.2024.11.21.09.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 09:17:03 -0800 (PST)
Date: Thu, 21 Nov 2024 12:17:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 10/12] qom: Create system containers explicitly
Message-ID: <Zz9rDA_xlgweZzeP@x1n>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-11-peterx@redhat.com>
 <Zz8LwhXsa6ail5qo@redhat.com>
 <64d02784-adde-459a-a019-10cdca93734f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64d02784-adde-459a-a019-10cdca93734f@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 21, 2024 at 02:01:45PM +0100, Philippe Mathieu-Daudé wrote:
> On 21/11/24 11:30, Daniel P. Berrangé wrote:
> > On Wed, Nov 20, 2024 at 04:57:01PM -0500, Peter Xu wrote:
> > > Always explicitly create QEMU system containers upfront.
> > > 
> > > Root containers will be created when trying to fetch the root object the
> > > 1st time.  Machine sub-containers will be created only until machine is
> > > being initialized.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >   hw/core/machine.c | 19 ++++++++++++++++---
> > >   qom/object.c      | 16 +++++++++++++++-
> > >   2 files changed, 31 insertions(+), 4 deletions(-)
> > 
> > 
> > > diff --git a/qom/object.c b/qom/object.c
> > > index 214d6eb4c1..810e6f2bd9 100644
> > > --- a/qom/object.c
> > > +++ b/qom/object.c
> > > @@ -1734,12 +1734,26 @@ const char *object_property_get_type(Object *obj, const char *name, Error **errp
> > >       return prop->type;
> > >   }
> > > +static Object *object_root_initialize(void)
> > > +{
> > > +    Object *root = object_new(TYPE_CONTAINER);
> > > +
> > > +    /*
> > > +     * Create all QEMU system containers.  "machine" and its sub-containers
> > > +     * are only created when machine initializes (qemu_create_machine()).
> > > +     */
> > > +    container_create(root, "chardevs");
> > > +    container_create(root, "objects");
> > 
> > This is where I would expect 'backend' to have been created
> > rather than ui/console.c, though you could potentially make
> > a case to create it from the machine function, snice console
> > stuff can't be used outside of the machine context, while
> > chardevs/objects can be used in qemu-img/qemu-nbd, etc

Would it hurt if we do it altogether here even if it won't be used in
qemu-img/qemu-nbd?

IMHO we should either make it simple (assuming empty containers won't hurt
there..), or we should just leave "backend" to ui/ code, so we don't assume
which binary is using the ui code: whoever uses it will create the container.

> 
> What about creating "backend" container in qemu_create_machine()?

I remember I started with that but it didn't work.  IIRC that's because
machine_initfn() (or somewhere around the init code) requires the
containers to present, hence it's too late even if we create the containers
right after this line:

    current_machine = MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));

-- 
Peter Xu


