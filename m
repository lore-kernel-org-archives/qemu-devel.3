Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0D2C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU50B-0007R0-75; Wed, 17 Jul 2024 09:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU509-0007Jq-9w
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU506-0000S0-QK
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721224041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OvGwVW7r3A2igVXTPRrCCVsmMj1JiRPlritc6g5WEbQ=;
 b=e2os4VZfFTzAbZoiHq24RY/K4pxNMeF0PVPXfRU2Kox/Zsf17tqP9j4yUGfIYg5qKveOKu
 FuSYhF3ui4YGeJG+3m/RVCSgCW9OtSTG/sKyo3qaK8xvCDcvY18rAICt9VMtg1bnG90qVY
 gY1R3BlW8Gs/cBcVJOPB+9AUgKWr/bs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-OFV84l4vM9SnkdoZgb35ug-1; Wed, 17 Jul 2024 09:47:20 -0400
X-MC-Unique: OFV84l4vM9SnkdoZgb35ug-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1469929a2so4748585a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721224039; x=1721828839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OvGwVW7r3A2igVXTPRrCCVsmMj1JiRPlritc6g5WEbQ=;
 b=kG4tcdo68MyBeo0c2tmKnTPiem+ZW4xmCt0tb6UxdxYeK9mfJ/VD9e3FenIBBtDYhm
 yV626TLSYlKBXuXQNnApVkiF/pK0nid8QA2kEAQtM3ZGMW1w9ysSczO7k45gJ2Tj+n+y
 daaXj/2VuTqSwmc8LHsynd4wC24eFDED3XNW3VMBrL/iKPa7/SzUD2f15gj14H692smq
 rN8hYE/4CRF7QmEJ4Ov0qt6Q9vJ7LU3gIsBhdzE4WaF7b0PzQy5d0O8T8AYbNBoAU1Sx
 xIOUyZv3oU6oUs1VSWU3/Hw0Yqhr8QmmNz/tN9q7zEXuBt3z90jAOIUPNMB7VRKxEOK1
 Av7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX66wLbBOBitWqS0L7OSUM4fk+ZTe4Zlqj8EkGpfxvrNweRJFXmwAN3nQ3xWIR+errPutoiABTFsxKQl3kXudGIVQSvWK8=
X-Gm-Message-State: AOJu0YxPvxfrBXbiBRnenwMRlMTuk+9l/O/GCPJDi3xES+3SvUEt3G4Q
 z9yOlol+JWvSASQc3FGPS9MP8Nlz6V35FmryLvIVmxpt/caDRAd3A0fIwNo2ze/ItfT7Ku/20vz
 mPmxZDPtLwJsRHPyptSQjjbY9Wa9+WdIJVUb9CqztaBK2N8JxXPCC
X-Received: by 2002:a05:620a:244e:b0:79f:84f:80b1 with SMTP id
 af79cd13be357-7a187518584mr116558685a.7.1721224039682; 
 Wed, 17 Jul 2024 06:47:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhN7iQLmVPAleHc6xG1/PvWSjAvdpREw8XUvnWFfPqIKJy82B5Tc2GjyqEq3d/C+YjW3ugug==
X-Received: by 2002:a05:620a:244e:b0:79f:84f:80b1 with SMTP id
 af79cd13be357-7a187518584mr116556185a.7.1721224039225; 
 Wed, 17 Jul 2024 06:47:19 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160c6df5dsm402866785a.111.2024.07.17.06.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 06:47:18 -0700 (PDT)
Date: Wed, 17 Jul 2024 09:47:17 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Jason Wang <jasowang@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH 0/2] Postcopy migration and vhost-user errors
Message-ID: <ZpfLZbiJ3cn6fEba@x1n>
References: <20240711131424.181615-1-ppandit@redhat.com> <Zo_8fpKH8oBA8WV1@x1n>
 <CAE8KmOzsGaPtTFsjcRkyd8n_fPzXeFd+c38Eb=aLG0_MdO+yKw@mail.gmail.com>
 <ZpUmrTrEnx0RcO2y@x1n>
 <CAE8KmOxY_LQ9vNjvmPyRgk_dcnEZFG6_M1q14473NQoBUSM4ow@mail.gmail.com>
 <ZpbuChi9QMIogmuS@x1n>
 <20240717045335-mutt-send-email-mst@kernel.org>
 <ZpfIDUwS9vawpzT5@x1n>
 <20240717093911-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717093911-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 09:40:06AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 17, 2024 at 09:33:01AM -0400, Peter Xu wrote:
> > Hi, Michael,
> > 
> > On Wed, Jul 17, 2024 at 04:55:52AM -0400, Michael S. Tsirkin wrote:
> > > I just want to understand how we managed to have two threads
> > > talking in parallel. BQL is normally enough, which path
> > > manages to invoke vhost-user with BQL not taken?
> > > Just check BQL taken on each vhost user invocation and
> > > you will figure it out.
> > 
> > Prasad mentioned how the race happened in the cover letter:
> > 
> > https://lore.kernel.org/r/20240711131424.181615-1-ppandit@redhat.com
> > 
> >      Thread-1                                  Thread-2
> > 
> > vhost_dev_start                        postcopy_ram_incoming_cleanup
> >  vhost_device_iotlb_miss                postcopy_notify
> >   vhost_backend_update_device_iotlb      vhost_user_postcopy_notifier
> >    vhost_user_send_device_iotlb_msg       vhost_user_postcopy_end
> >     process_message_reply                  process_message_reply
> >      vhost_user_read                        vhost_user_read
> >       vhost_user_read_header                 vhost_user_read_header
> >        "Fail to update device iotlb"          "Failed to receive reply to postcopy_end"
> > 
> > The normal case should be that thread-2 is postcopy_ram_listen_thread(),
> > and this happens when postcopy migration is close to the end.
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> 
> 
> OK, so postcopy_ram_ things run without the BQL?

There are a lot of postcopy_ram_* functions, I didn't check all of them but
I think it's true in this case.  Thanks.

-- 
Peter Xu


