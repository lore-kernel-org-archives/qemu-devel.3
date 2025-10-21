Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B34CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEEC-0003kX-Jf; Tue, 21 Oct 2025 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBEEA-0003k9-TX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBEE6-0003TZ-Tu
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761060278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v9dqkn9tZcBSjgA2cfvO6WpUs4FOwRRs9Us7iGehxio=;
 b=Uy0qExpn1BNoc8yFwbkn0cXV0zVhAfDwEmh2PLqE9J3UXgINsrSAeQk3wgv+5bIWQ9Podr
 MARyzA4rQBO7lMtoShKRwXQXJLOBVcNNth5oyNqRPpYnfzdkv3FaX4HeAE+Mna3Np8fiAL
 Kbs8N8l+0KUTDSoUb5mDoOKEyqAsWwQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-TQ1aJTyWOyyi-1xMcvsv9Q-1; Tue, 21 Oct 2025 11:24:37 -0400
X-MC-Unique: TQ1aJTyWOyyi-1xMcvsv9Q-1
X-Mimecast-MFC-AGG-ID: TQ1aJTyWOyyi-1xMcvsv9Q_1761060276
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-79e48b76f68so291152716d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060276; x=1761665076;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9dqkn9tZcBSjgA2cfvO6WpUs4FOwRRs9Us7iGehxio=;
 b=KNAyBelJ5AezQ0wRIn9zUJMW8s5euGuQV1odTQeTkqqMlvbSqaLDDl8LGPE9G1tZxv
 6UeDYHAFIIwl0fZ0Iaj8WdS8AqP68S1wejAAddGu7oyTES47bDuRl0cbzM8Dkmj3xOH5
 smzZDesjM8UbOfAZ6KLqkC7VNqvE8k7/ztIkQLmB/q3+CkVFBWxOOnnGuxdps0kIrf6R
 cbNjNyHXCSymAKscpKi+IkmTtqHxSN2QfXLYZFP74yVwVsIgI1r5cnfPyj5dtesoH1Px
 b9x/oZt2bdxZYG3sVDPQGuxvtoOFRyPrU8752bkCmPdLglhq9aP2OpQaGiEfd7ZsNn23
 8DUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgWIGsnzFR9DGCZztPQiOyANU6xJ1NNPYQQGqfa1+JGZ2B7WacO9pzshzqGohIMCD0dHqccbo6HCGj@nongnu.org
X-Gm-Message-State: AOJu0YxJAO4JShCpRE4jsokyA3I565VLdynHWEpkI9h8I6Q1qihqHrXy
 VAaQTmIWk1mu/wH+CO/RtgMEcpv5yRTgvAbKiEPHUre9dIDIBZ0+VsIJeC6Q+rUnmgFcHfC9mjq
 bSfvkMy1lPJG1fTmYOsVxxOzCnIP0ZVL3ket3PLQw2pKk49iJW3ManHSY
X-Gm-Gg: ASbGncshsgqITaqATIwHy+dghzUQOMePc4RDOK77QgPYzrrQNnukSlFQ8PaIvW7Y8/x
 kLmInbUgjruCJKFiAJZxXo4GFTAceokxfqL+3iXIXXqUtqksgk30PCBw0J/WRAIoLQxpXJ6exRy
 peD3fLYSdmby4ktYZ+V7gCcS8LVNPB9h39KggShs6O1/zO1gJoKoTOmRRIzUcW2fIvJ7IaWSwh0
 rxOLP4jL38/Ibu3yKP28C+/kEqQfna1GhwIfHQiaYn0Ta/9OHVe9NYarNhc9zqYf/+huK/2MU29
 MIX7HLtTFQsQeKUeVC1NwEZPbm5Hc+zF6tmatHkTfCDEf+gYQlps9DgpSeApvnX/BOk=
X-Received: by 2002:ad4:5cc1:0:b0:7ff:7b64:840a with SMTP id
 6a1803df08f44-87c2062d7a5mr206750886d6.33.1761060276269; 
 Tue, 21 Oct 2025 08:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+HxaYKqqEYvnVgk7TdxoKQjUbGUiDpE8J6qngb2zsar9om3f1gzdsu50pn6Fks63wK8xsBw==
X-Received: by 2002:ad4:5cc1:0:b0:7ff:7b64:840a with SMTP id
 6a1803df08f44-87c2062d7a5mr206750266d6.33.1761060275409; 
 Tue, 21 Oct 2025 08:24:35 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d028a9987sm70703796d6.44.2025.10.21.08.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:24:35 -0700 (PDT)
Date: Tue, 21 Oct 2025 11:24:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Dhruv Choudhary <dhruv.choudhary@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] Improve error propagation via return path
Message-ID: <aPelsAunpYhiQJ0h@x1.local>
References: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
 <aPeaBNIzrq0Ni4IM@x1.local>
 <41985b55-f99d-47ff-964c-79adc05f3ea1@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41985b55-f99d-47ff-964c-79adc05f3ea1@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 21, 2025 at 05:54:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 21.10.25 17:34, Peter Xu wrote:
> > On Tue, Oct 21, 2025 at 07:52:53AM +0000, Dhruv Choudhary wrote:
> > > Use the return-path thread to send error details from the
> > > destination to the source on a migration failure. Management
> > > applications can then query the source QEMU for errors, as
> > > the single source of truth, making failures easy to trace.
> > > 
> > > Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
> > 
> > +Vladimir, Dan
> > 
> > IIUC we may still need to know whether the src QEMU supports this message
> > or not.
> > 
> > OTOH, we have introduced exit-on-error since 9.1:
> > 
> > # @exit-on-error: Exit on incoming migration failure.  Default true.
> > #     When set to false, the failure triggers a :qapi:event:`MIGRATION`
> > #     event, and error details could be retrieved with `query-migrate`.
> > #     (since 9.1)
> > 
> > This patch is going the other way.  That feature suggests the mgmt query
> > the error from dest directly.
> > 
> > We should stick with one plan rather than doing both.
> > 
> 
> Why?
> 
> exit-on-error=false is good anyway: when QMP connection is established, the
> management of target QEMU process is the same: we do call qmp commands to
> add devices, etc. We get QMP events. Actually, exiting is unexpected, better
> to fit into QMP protocol, continuing to send events and wait for qmp quit
> to exit.
> 
> Passing error back to the source simply improves error message on source,
> which otherwise is often confusing.
> 
> Using both, we of course see same error in two places.. But we do have two
> QEMU processes, which both handled by on-host managing services. We should
> correctly report error on both parts anyway.
> 
> Improving error messages on source is just and improvement, which makes
> current behavior better (with or without exit-on-error=false).
> 
> Removing exit-on-error=false semantics (with or without passing errors back)
> would be a step backward, to violating of QMP protocol by unexpected exits.

I didn't mean to propose removing exit-on-error, what I meant is when with
it this patch doesn't look like helpful.

Has libvirt been integrated with exit-on-error?  If so, IMHO we don't need
this patch anymore.  To me it's not an improvement when with exit-on-error,
because duplicating the error from dest to src makes it harder to know
where the error happened.

-- 
Peter Xu


