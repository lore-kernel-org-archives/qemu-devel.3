Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E09C282E3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpnzi-0004HO-2f; Wed, 05 Mar 2025 07:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpnzc-0004Go-Jf
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:36:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tpnzb-00033o-44
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741178213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RiBazbux6JyE4yKZIEvJTN2VowKtIkeLHQ2IHBHxQaw=;
 b=Dx5VxGSMo2vO/uqtXka+T4w0pH0wAJhFhkTU3G9zGGo/6GacGQWkxnYWdS89U0UAGU6+3q
 2v33DdgaBdSy0HypNdmXdXaHnocfos3UU9KK+GN/ay1kIb+dFDVKauTKfkFEcGXUxq5mta
 waPn1Ah2cX3FkKurUgOICQo3kIcCVWo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-SCZwx1yKPbiQONCfMX3gNg-1; Wed, 05 Mar 2025 07:36:51 -0500
X-MC-Unique: SCZwx1yKPbiQONCfMX3gNg-1
X-Mimecast-MFC-AGG-ID: SCZwx1yKPbiQONCfMX3gNg_1741178211
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e8c68dae82so69321586d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 04:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741178211; x=1741783011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiBazbux6JyE4yKZIEvJTN2VowKtIkeLHQ2IHBHxQaw=;
 b=DGOt1n10/HUuctyU/Mvp/YKa70RMHN2UkgN2iolndA12rVdPfok8Lq4s0CLqq4ZZuP
 r9yJ0WXo23dlz44lXgALsuaQdOAYitTaPnoTyITbBPLzLXTLPKPP76NsWoknSqJtuOD7
 9om1brFzXw4XG2H9uzhAOFexmLIefgLGXS9IoZM5UeV2OFSz743GpsJFuP7sazw9quM0
 w3Uuq3hgT3dB4by5VBHIA5RpGqc6I3/15o7bU285rYSJ2UL0hxJr5Hd+Pz5NI92oAiCH
 N6gd8CsdrJ8UC8lbbUBl7JpM13VM25Hh6nYm8sgjgYldZiDTpgQpFj55xohMRAkZ9Xzm
 Tggg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIB+H7w9I8yYEELOoOnWiRQPvd9PBQbxfFuFlMhnIm/XA1rieHkoPlHcNMA3rntxrlMP75CDCltCoo@nongnu.org
X-Gm-Message-State: AOJu0Ywmy30nAI7vNh5nrpiCOTeoJzJqMlZpds0RurHpl2ehj4asHM3D
 5pSjAQ6Q4Xfq6wpB6lASsNj9uxqQJJMmmC3/foH9BfxcvHCDpFWerp36owFUdiwgszuYJybtgkP
 /X4UlT3Q5wnPbRudI8xxFU7imoMA7EjGM/axsWoS1kFGIdqGKbweQ
X-Gm-Gg: ASbGncu2WMxtr2UbpSCqt/fVaTAUbAtWQ2T1zfSng3liQJZCIjNfr5PzI1E+VJMcwlp
 3RXKdf55p1TAX6w9WdeERpVJU4EI9gPsDIgy/FhG1hiGkUYsyawGgW6QuTVOONpAaKWr39k3KC4
 cZlMu7hj4ePDpcWdYzbbp8vgiGrzPVBTJ7D/Lw5yp7krVPGnJrHa6UT6jeK1yEmKJtO6zRJOwko
 mcPMnrWBBHeMZnKqRe4W/q5/8d7+y7oXhzXnYc1t1j03mKssFHapqzMeoJqz5Px3PzzoJMOKW7G
 6FBpmz8=
X-Received: by 2002:a05:6214:1d26:b0:6e8:8934:3383 with SMTP id
 6a1803df08f44-6e8e6daeaf5mr37827196d6.41.1741178210692; 
 Wed, 05 Mar 2025 04:36:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEsYNl0L5eXX5EP92lM8lOcuDdCEk2BJxL3vkoJCwsqvsgdBfbK+m/xR/TTXUZB6ZjCeKYmw==
X-Received: by 2002:a05:6214:1d26:b0:6e8:8934:3383 with SMTP id
 6a1803df08f44-6e8e6daeaf5mr37826966d6.41.1741178210402; 
 Wed, 05 Mar 2025 04:36:50 -0800 (PST)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976616f5sm78664786d6.68.2025.03.05.04.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 04:36:49 -0800 (PST)
Date: Wed, 5 Mar 2025 07:36:47 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 17/36] migration: Add
 save_live_complete_precopy_thread handler
Message-ID: <Z8hFX8whgLHOxXXe@x1.local>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <eac74a4ca7edd8968bbf72aa07b9041c76364a16.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eac74a4ca7edd8968bbf72aa07b9041c76364a16.1741124640.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 04, 2025 at 11:03:44PM +0100, Maciej S. Szmigiero wrote:
> +    if (multifd_device_state) {
> +        if (migrate_has_error(migrate_get_current())) {
> +            multifd_abort_device_state_save_threads();
> +        }

I assume this is ok too, at least as of now:

Reviewed-by: Peter Xu <peterx@redhat.com>

> +
> +        if (!multifd_join_device_state_save_threads()) {
> +            qemu_file_set_error(f, -EINVAL);
> +            return -1;
> +        }
> +    }

-- 
Peter Xu


