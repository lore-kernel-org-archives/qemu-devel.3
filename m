Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADC2D1BDED
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t83Tf-0007z6-5y; Mon, 04 Nov 2024 15:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t83Td-0007yS-Gt
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:15:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t83Ta-0008GN-It
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730751300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LTSXr0hilBsizk9EU+p/GmkpTrRo9oFzrrryjoXavyA=;
 b=RX/AnTDCuzGHU7GrLnBmfTX+/HEka+6foF+0gEF6rKrPurYIuNHf0csEV9XNv49A/eQIk1
 uErOhLFcyQWWLanfm4spdmorvZ+z8iudvy0FbtFD27/JcqTQsL+OvbsI4QqN2nllyk7sSy
 x59T9J2ZuJXQBw6ycxymqYFMprysj2U=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-GiuJbwtHPi-fUBczJZjMNA-1; Mon, 04 Nov 2024 15:14:58 -0500
X-MC-Unique: GiuJbwtHPi-fUBczJZjMNA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-71817b35f3fso3370566a34.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 12:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730751297; x=1731356097;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTSXr0hilBsizk9EU+p/GmkpTrRo9oFzrrryjoXavyA=;
 b=r9hx3c8WgGeseTtoBukxttf5mEyD8W8hDm70jSN9RiOeLnoeOU9+V5upQYtRZFOHG7
 e0cyWxlM/U35hnACW8kItGoJCnSeiM5zd5pCudsJfM+XneX5Q+qwRadHMCsO9k3ayNZF
 nAnScBTSEs+fmULQih4Rw2TIWQzngxQ7DvdZdwnykCp24J1cL46DWvQCTm7QWRxkUXnb
 Nzlq6+Zda+kN+IfBff2mloGdpIN1ijeB7WCI05riqpXL9C9baf2OAsXR1A36VDhZBASI
 Sdq6wEHk8MoX7RqVF9asb/0+2QoU14bgoShHu4kl1c3T6EsEcWI8+DbDyHjAoeWjcHfo
 kXOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE4nGvA2aCPK8NIdwXx4cDaTkEaNRdpsnS9L26aHzVBfnMI6QUdXdBs6VIwfZR3Wj9tZSHIqxrd/8c@nongnu.org
X-Gm-Message-State: AOJu0Yyz2+RcjEywTSIj+XeXQ8vqVnkGDiWfIA7dw+0/iwJ3p91UrYPy
 abwgnmxVUvYx+e50bONZNqU7inLzzG9Hu7eKuuRlGxmlkKNcitM+7+E9MOSvfLn3qfex585YE0Y
 TeB4YmoW/za1xMN7TValwYGiN+7eZeL6lXnRnU+skhyrWUpcIfpeB
X-Received: by 2002:a05:6830:2703:b0:710:b19a:b999 with SMTP id
 46e09a7af769-719ca1b2ccamr13230329a34.14.1730751297584; 
 Mon, 04 Nov 2024 12:14:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEqGEG4d5bJg5Gzu7z04xbLN6e4z5NjfYSPDtshokpzvWevqWPuK2/3ORuJQoDc7PZ9W2KaQ==
X-Received: by 2002:a05:6830:2703:b0:710:b19a:b999 with SMTP id
 46e09a7af769-719ca1b2ccamr13230305a34.14.1730751297322; 
 Mon, 04 Nov 2024 12:14:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ec704e4fc7sm1962774eaf.15.2024.11.04.12.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 12:14:56 -0800 (PST)
Date: Mon, 4 Nov 2024 15:14:54 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
Message-ID: <ZykrPpmwMg7N2Rbe@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 04, 2024 at 08:51:56PM +0100, David Hildenbrand wrote:
> > I did that previously, and Peter objected, saying the explicit anon-shared
> > should not override the implicit shared=off.
> 
> Yes, it's better if we can detect that somehow. There should be easy ways to
> make that work, so I wouldn't worry about that.

I still think whenever the caller is capable of passing RAM_SHARED flag
into ram_block_add(), we should always respect what's passed in from the
caller, no matter it's a shared / private request.

A major issue with that idea is when !RAM_SHARED, we don't easily know
whether it's because the caller explicitly chose share=off, or if it's
simply the type of ramblock that we don't care (e.g. ROMs).

So besides what I used to suggest on monitoring the four call sites that
can involve those, another simpler (and now I see it even cleaner..) way
could be that we explicitly introduce RAM_PRIVATE.  It means whenever we
have things like below in the callers:

    int ram_flags = shared ? RAM_SHARED : 0;

We start to switch to:

    int ram_flags = shared ? RAM_SHARED : RAM_PRIVATE;

Then in ram_block_add():

    if (!(ram_flags & (RAM_SHARED | RAM_PRIVATE))) {
        // these are the target ramblocks for cpr's whatever new machine
        // flag..
    }

-- 
Peter Xu


