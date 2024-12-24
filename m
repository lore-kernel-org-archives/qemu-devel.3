Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2329E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 19:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQAYm-0002RB-Bq; Tue, 24 Dec 2024 14:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAYj-0002Qy-D0
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAYh-0006xt-T6
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735068431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUudhzn7OInzKbXPb+eTqs97wJLfRXCYVSLwWGp7mc8=;
 b=Hf0VhvuByfw3znxC3mGWPOXkPyDGKDBN5+qcLq/qCfdDpYM50Mta/DsoII+4h/DmWvQKYr
 a6LVTwpg6Ya/oyQsB6IUHFFCcLPFpDw96DAwiLlUeZMNg8b3uQdn/kqpPQBMcm0bKinz6I
 Emp3cuxd7pFaErTwtQNmYh5wm+Z86PE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-8N1pk-snMFKnWpsFlGWPdw-1; Tue, 24 Dec 2024 14:27:08 -0500
X-MC-Unique: 8N1pk-snMFKnWpsFlGWPdw-1
X-Mimecast-MFC-AGG-ID: 8N1pk-snMFKnWpsFlGWPdw
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6dd43b16631so30853146d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 11:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735068428; x=1735673228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUudhzn7OInzKbXPb+eTqs97wJLfRXCYVSLwWGp7mc8=;
 b=EBKYHcx/PunMCkRFL+K5zI8vuowSKJUq2vhFT7MWi/rdmPKdj7N92SKO0vrWs68lUp
 u4IEw6tU6Sd435EGpMKWOcEfS5zRxYveH2T+GGP7IDAinbabKLXQKAupN94P4DfLaWAW
 DIpQwOLf1yMG71V+jgsADNOtTYtMWV+TH5Ub3Blg/vY4EUMtKw2xG3Y/Wdm3ZdO9TNmJ
 +FH7G8cMuRhpXAHXf7+a3TlhtAB6n1212oMU59zZxPib/Mc7LXawjRGgTCGITytr5VAs
 BV+GG6g8jgnqj5gNPZzZEoBZTygwnfxVz+YuxidX+gzjmz+oXBbBkqwgMGH4BhZMDyZT
 Jbhg==
X-Gm-Message-State: AOJu0Yw71PBzBUWaIdYAZRhuoSbm93btUD1C6E0pwfAU8KpbPqxh/4vn
 teI+oAsNfCAnFO9DrGZXfoRxVANQ0HQtkQ1cB2IKXNMUNamadozyYPYtvhf1pzwu1536A3HOjl+
 dr+K4zANoncWDo7VUpI0hAoFXSlG1G97Bpq8U/4Ev/PKL1G4JiI+y
X-Gm-Gg: ASbGncvHRoW21itE6wVX+Suh9S7TgyrtssiuboKSLSKub7B/p5E93obp3gY3w+YoLIq
 4YHGa6op2GoZG97a2H/K8FOyuwF6M4enSvxFZjfZrHVKv1A8t8X5KnSLk3fRcmaQSqDuIj59cX1
 ziQXXD9Wd44GP9patdx4RBJVGGZdkHTKsyi65yprtmWPGjFhBw7qJFzfRLPHhvgls/9Fm660Q54
 8WTRI5NjcFRsdQ++K4IJmcb2vDMdOO6E/zd4UU8Zbq9HDvQwfAieeG3CuH/6N6dXSbOxuzUcYbV
 yEunKm4YbHXP5trllw==
X-Received: by 2002:a05:6214:212a:b0:6d8:9bfd:5644 with SMTP id
 6a1803df08f44-6dd233aecb5mr269006776d6.49.1735068428145; 
 Tue, 24 Dec 2024 11:27:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5jDYRSAZzwaKxR4wUYs9KDLJDwz5HqTvr5VYmMVmR72R4hhnygBvmhXW1ANkS6d1YKirF9Q==
X-Received: by 2002:a05:6214:212a:b0:6d8:9bfd:5644 with SMTP id
 6a1803df08f44-6dd233aecb5mr269006506d6.49.1735068427800; 
 Tue, 24 Dec 2024 11:27:07 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810d5casm55505126d6.39.2024.12.24.11.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 11:27:06 -0800 (PST)
Date: Tue, 24 Dec 2024 14:27:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 18/23] tests/qtest: defer connection
Message-ID: <Z2sLCDLJwrTwrXEt@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-19-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-19-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 24, 2024 at 08:17:03AM -0800, Steve Sistare wrote:
> Add an option to defer making the connecting to the monitor and qtest
> sockets when calling qtest_init_with_env.  The client makes the connection
> later by calling qtest_connect and qtest_qmp_handshake.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


