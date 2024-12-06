Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C98E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 21:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJgK9-0000sF-5j; Fri, 06 Dec 2024 16:57:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJgK7-0000s0-Lr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:57:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJgK6-00013m-35
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 16:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733522234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EphKAictLomuakBDs8qDaxfHzLzw0ib3TFzITVFQPBk=;
 b=f2QEZhqScUPqAN5/DEUHRHTN9wXnYvsk94pSPHjqvjrli0BCM8pXXKUf08tEaTbT9P0cks
 0gbeJdH8YiycFC5bemcrNa/6c4qigwQA/a36F6h4nPmiWq0nOUOK1AzXzOIAHm1KREDxtW
 pY3f1ZkXrdzTxLckglIL6rV+iG1C+xQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-gUBMzyoZOwqnnxv3lO_VUw-1; Fri, 06 Dec 2024 16:57:12 -0500
X-MC-Unique: gUBMzyoZOwqnnxv3lO_VUw-1
X-Mimecast-MFC-AGG-ID: gUBMzyoZOwqnnxv3lO_VUw
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-841ca214adaso244802339f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 13:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733522232; x=1734127032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EphKAictLomuakBDs8qDaxfHzLzw0ib3TFzITVFQPBk=;
 b=wrMtgADP1FWWXB8VowtgOeBXjNwlHLTQCzDjXUP2THLBURAIilnWNjEYeeUgxrfXuo
 mFM6AfCOJRQUAAIMoPYdR+N5JX100YKl2zEzrUJylXangYlYhlwJQ54S2Vpjy8PuFRKn
 G7gAsx9vGcu7PPbiNU+sJkrR8OxxamZO4X2EcnYJj4GepRL97c0gtpXDjtWy59FUtdww
 DA4m4AzXVI+AotXDKg0l4ciy2brJfekEIiu42nCvzfUto/izWxsm6kOOOZcKGM03/Vs5
 Qk8JZVYT51HiXmVmnYFNGnko0DqQgPe85D1hcNCLxknDtG1eW/qCc3CpYgsLlcmlkbAz
 BLsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWmnrc9nsp1yAAZMZjAbGpPVsKSUm0niVIoNpNtR4awjjflCdVdUysnJIrC01u4bS1j2ccWJyMELGo@nongnu.org
X-Gm-Message-State: AOJu0YxmPJfmaVgFjqy3NMHkO1o9RxOcJyj75PS4eY9+215zniBe56CD
 dhcQQ1fHCvHTybXmAPfkRGtZpDgWdeWLt4XugvuzJQkZO3gm/FlZhepIaHxqRRyZBCudugK8Elj
 CqyjF4NiRZrWYhXAYt+2HSOWz+ROMFx14F6qd2G2vo0Y2LO1fzrII
X-Gm-Gg: ASbGncuAnxQQ0IYIm1bFoP5GLt8gtwsrDp5kTL53bF5PVAPwqHE+kiIjyHap3RmWU6f
 w6y7QYF6T50+DAhKv5AEzbDNG6l9DZpaFYflEc72FOuEmxpEDY0uWzNfOeKei3S2qZW3Dz1RZpk
 FsgAZsX2wE7Fhe/tnRShINdxNH3wjovYWHFUWN7nFMiy91WlL5hJhI6t1APBgYU/4SPpncbmwmg
 ar6fCQ/IjudFsAlRps62C2WN8aJ4vMV9UvWsyM4wFWqhQAwxeP5ZIj59B7k2TZqEz4xnMXK5clK
 PRvLBIcf4SU=
X-Received: by 2002:a05:6e02:1988:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3a811dab8a4mr64576905ab.3.1733522232223; 
 Fri, 06 Dec 2024 13:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/woPo6YhEI4DegUcX3E4bN6kIDYdea5ThxynNc1qumY6hytVrsNMBw6GYEnhcprJuAqdBrg==
X-Received: by 2002:a05:6e02:1988:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3a811dab8a4mr64576725ab.3.1733522231976; 
 Fri, 06 Dec 2024 13:57:11 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a82sm1014959173.93.2024.12.06.13.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 13:57:10 -0800 (PST)
Date: Fri, 6 Dec 2024 16:57:07 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 10/24] migration/multifd: Device state transfer
 support - receive side
Message-ID: <Z1NzM1uT2wjyynWT@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <8679a04fda669b0e8f0e3b8c598aa4a58a67de40.1731773021.git.maciej.szmigiero@oracle.com>
 <Z1HPf850jFdBD9IS@x1n>
 <454ab654-634c-4286-87f8-6379aa6fa27c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <454ab654-634c-4286-87f8-6379aa6fa27c@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Dec 06, 2024 at 10:12:27PM +0100, Maciej S. Szmigiero wrote:
> Same here :) - the sender sent us possibly wrong packet or packet of
> incompatible version, we should handle this gracefully rather than
> assert()/abort() QEMU.

Ah, sure.  Feel free to keep them.  My R-b can keep.

-- 
Peter Xu


