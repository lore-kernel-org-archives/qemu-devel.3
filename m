Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE59CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FlB-0001dt-UM; Mon, 29 Sep 2025 11:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Fkr-0001a2-Ta
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3Fkl-0000aE-BM
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759159524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JXBe3NS8d0bVtOqVULXaqNC7wJclStTQnAXF8BKjajk=;
 b=g/BI4dHE9K0vRWEgN08TgWyXBFu648BZKs2W+o62m6S9gztBuICqZehZSNWDMSc0KnqefV
 taJQ0uzpkUav7RInKiLNnkFDKDfaoUKFzyHb10vMwSM+/5wIxhaJdFOwZRbGwFQFrwNW3d
 Lfa/CxVArgG6oECFb+XxAtbna3BkkUU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-A5d_74LjNzmKgRUJXGzpZg-1; Mon, 29 Sep 2025 11:25:22 -0400
X-MC-Unique: A5d_74LjNzmKgRUJXGzpZg-1
X-Mimecast-MFC-AGG-ID: A5d_74LjNzmKgRUJXGzpZg_1759159522
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-857003e911fso1130776585a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759159522; x=1759764322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXBe3NS8d0bVtOqVULXaqNC7wJclStTQnAXF8BKjajk=;
 b=s3pXB5O5oYDXQh7UWAj3CfR22dm55WMEn5cimMYOiGKHpJCWDRcnUnZNYKxrAEvtLF
 uw/O3EZDv7SfnPO8LGFDyzmpbiVCzHfn/4QbZnNy8HnzgNWHBpLjbhkPosVxeakkk3i3
 J3aX0u4ffpze/7IVDPrjmHZaJlN4xYNygl91s/rw40sr3NnUVSdS7zrxxBviLaRkIJHc
 8pqVYNNIViCO27Ra1OYcjk7hu4Fouk/NKFEqAQQSvF0p83fP88tmPWE6hQFhdmAY5dMR
 iRJav3xTlH/GhniOLQtM9wg/jSrYNrpy6YjMRKwjuXspCbUXNI4wSMBgF8leDpff5q5t
 yA6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtfhZbJoX1SVUfUgwmKyX1mHCyiTQsvxbLDFyGEHs5m9HpqQ5Mq6meNFwBb303wZYxlqDzwFFNXPYQ@nongnu.org
X-Gm-Message-State: AOJu0YwDKxrrbxpmHMUJBscWWAfzAXe3xZbPwtgmSNO727Ab1y+Hw7LN
 ClG8k5CK/+DlllJnkIJi30RBbqHf+eBOjJKbCKW1hZ0t+3UWFI9CfY3XVAByeHoo8NSU3fkOnT4
 861snRuNu9Qc3alMgipmUORFydnC9KxZ+MJMvWfUvwd+/KRXpOjtOSLhB
X-Gm-Gg: ASbGncuLonhlny1VjiiXgdcExIaub3eTnq/nR9YxdTN85yDWib4g6odXKQPy/xWLOyD
 KTdJJScDP56qHodZuC7v0J4R7FCiRwmn9Ybh36JaDoHwDwqBbBNyuTLMBFY5CHrvfc9+GUHM1sD
 ECEJZxZHCK9t5j7eQsHmPcfDGZwXkooJZjGzXRnrqVOdYLZ+0fi11ra5S/dxB7TMXRzhWEkW0k7
 2zyjVhP77jzNLZGa8RWej+CC3z5GI1YeLhDpINn6MFJJkbRT0HkHuLVQ+T2zxU7V093LyG4YRoj
 wuNksq+iB01o6s8FcMfSgYBvmMYMQDK/
X-Received: by 2002:a05:620a:3943:b0:82a:930:9cea with SMTP id
 af79cd13be357-85aeada8fccmr2056497885a.76.1759159521427; 
 Mon, 29 Sep 2025 08:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHCBowV5FOyjIVNzReesHH2xY7wHGNv48xQqqDXQqpj8dHoBhMcqnGhNN7SiEkjWOFA10JqQ==
X-Received: by 2002:a05:620a:3943:b0:82a:930:9cea with SMTP id
 af79cd13be357-85aeada8fccmr2056489885a.76.1759159520489; 
 Mon, 29 Sep 2025 08:25:20 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db09f19d73sm79490771cf.1.2025.09.29.08.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:25:19 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:25:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v14 00/27] migration: propagate vTPM errors using Error
 objects
Message-ID: <aNqk3ecJ1rMndtky@x1.local>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
 <aNpILAhr8LaMFbcL@armenon-kvm.bengluru.csb>
 <aNqN05aj0CYttxd6@x1.local> <877bxhwcub.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877bxhwcub.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Sep 29, 2025 at 11:30:20AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Sep 29, 2025 at 02:19:48PM +0530, Arun Menon wrote:
> >> Hi,
> >> Gentle ping for the series.
> >> Is there something more to be done to improve this before queueing it?
> >> TIA.
> >
> > Arun, don't worry - I believe this is on Fabiano's radar.
> >
> 
> Wait, have I forgot and I should be the one doing the PRs?
> 
> The series looks good to me. I forgot (again?) to add a t-b last week:
> 
> Tested-by: Fabiano Rosas <farosas@suse.de>

Queued.. thanks!

-- 
Peter Xu


