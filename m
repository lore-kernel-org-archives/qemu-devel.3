Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1CAC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOet5-00082N-Sk; Mon, 09 Jun 2025 11:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOet4-00082C-DB
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOet2-00019q-SX
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749484691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qu11yv8QpMC8zdYE3kimKOt7btWruWvyXgJ4IgWE6I0=;
 b=Fi9sOWJ5mDLzbOrR0QoicToi6BaXql5LKYp55s8ymnjHMVtm6XhoBKXtI5ay1PTRr5ym83
 h7wiA2tDDWkKMgrY+6mKdHfHK1cMFD0pqJp++oRxi0sHmV/CuWLad67HEx7nrlyzYcCz4x
 KDFOUSYOQyQcteEhQmCqVHSV3UoSdDA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-KQKLJvNzOEOgrrzFw5xj3A-1; Mon, 09 Jun 2025 11:58:10 -0400
X-MC-Unique: KQKLJvNzOEOgrrzFw5xj3A-1
X-Mimecast-MFC-AGG-ID: KQKLJvNzOEOgrrzFw5xj3A_1749484690
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a589edc51aso109810871cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749484690; x=1750089490;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qu11yv8QpMC8zdYE3kimKOt7btWruWvyXgJ4IgWE6I0=;
 b=jcvFku+wTSLfyJbsx1Tq4gsBsy7EcfroZkMiHOYuyiuWkkH8/U1oSQkxcNxTkLlas2
 5pcmvec4HPq0YT9b4EDEmfET3wQi9t+D3n628WbEYk8tAPrYDZPpW2hqy75Db7cJjimv
 AeCH1XsRqVN9HDGJJVV2ZqznccJQEMS0zLFU22YVsnzFHR0Voxa+1UMTou5+YCIw6wA+
 3j7hy8wDV0dXnW1tB2E04MHQqTxtegardR50V0siD8UTGF/owt5EtTpqKG3+QP7kB1D3
 KF4TgiMXgKjqKdWhlWn2M1h7ssuzsDKH7PA1VtToapqd8LO4AmWwhdDWQZ24ekwrm3hV
 sJRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvQ4W8u5uCmxuQyvxDfFvqxfXXT6jYae2dQTDNH7NCVazbt/81N5uXwX9G/qcBZKxDwhgZtNuhUHIg@nongnu.org
X-Gm-Message-State: AOJu0YzUZX3uCBUsbqKjPw48m8q5Wlh4srA69YkGcshK/7CiHgiCCoa3
 dfX5ah4bihx6cE41HkEDsNmDe9V5BiVxP3SkbxWLc6QC+dR0EhSu2XuMQtDONTKqgNG60bZDjQy
 6Rt6+8/8MpGlY2vMoeHulLpUYSHC5wBTJ0Uvpqt/J6F18IPmTd6J2hqCN
X-Gm-Gg: ASbGnctW0bhgyltxTsbV6f0+ikybWLUtvymUwASa1Ehi7FYyRFjCaYIe7xZFWhX8Xia
 7UGkJkGjsZUGR8MlWakun74QyRPZwTatN91GVTUSiUinQzmDDFnEwpw6Jj3suOeJ5tszqr5qRcV
 HidjvXkY09veO0MU0qevkmrmO/42wIjidl73/jHSid946U7bqMX+7AelOAuF3aUlo+MddaufQdG
 HYt+hcyyyvHDy5bFJ0ATgh/+GGvHK/dyDwbR2YoP6ZvVZKkkbQ0618xJBMCsGb4EXHtTImA0HjU
 PMIJdcdJmAmiNw==
X-Received: by 2002:a05:6214:8090:b0:6fb:f00:48ad with SMTP id
 6a1803df08f44-6fb0f004c4emr151133746d6.18.1749484689885; 
 Mon, 09 Jun 2025 08:58:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7U6/0pfcLpnPp0swvqDnnH1GOv/2UEGVLumi1I6hknbzoMN/xHnxP/0qQfgrJyIOEl41W0w==
X-Received: by 2002:a05:6214:8090:b0:6fb:f00:48ad with SMTP id
 6a1803df08f44-6fb0f004c4emr151133356d6.18.1749484689493; 
 Mon, 09 Jun 2025 08:58:09 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95d7sm53493656d6.9.2025.06.09.08.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:58:08 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:58:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcEj-_C3y0mR197@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <aEb3pRkQK30JBf04@redhat.com>
 <aEb-umgh0VP2sKGW@x1.local> <aEcBLLwB9vZ33k8Q@redhat.com>
 <aEcDi6Z7pDeiRqDe@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aEcDi6Z7pDeiRqDe@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Jun 09, 2025 at 11:53:47AM -0400, Peter Xu wrote:
> On Mon, Jun 09, 2025 at 04:43:40PM +0100, Daniel P. Berrangé wrote:
> > On Mon, Jun 09, 2025 at 11:33:14AM -0400, Peter Xu wrote:
> > > 
> > > Now I think I know part of what I've missed: I used to think the "config"
> > > of per-QMP-migrate-command can be totally temporary for a specific
> > > migration request, but then we need another MigrationState.parameters_2 to
> > > cache the old or vice versa; that's probably not necessary.  Now I think it
> > > makes sense to overwrite any settings directly, hence I think I changed my
> > > mind on question (1), YES is fine here.
> > > 
> > > For (2), why it would introduce any uncertainty for mgmt?
> > > 
> > > If the mgmt app can both: (1) query from qapi schema knowing all the
> > > parameters supported, then (2) specify all the parameters in QMP migrate's
> > > "option" parameter.  Then it's literally overwritting all the parameters,
> > > so it's predictable with or without completely removing global settings as
> > > an idea?
> > 
> > That is relying on the mgmt app specifiying absolutely every config
> > parameter that exists. If they miss anything, then the behaviour is
> > not well defined, as external global state still affects things.
> > 
> > This is the same situation we already have with migrate-set-parameter,
> > where mgmt apps have to know to call migrate-set-parameter over & over
> > with every possible parameter to get back to a well known starting point.
> > 
> > The command needs to run with the parameters provided in 'config' and
> > no external global state, whether from -global or any prior call of
> > migrate-set-parameter
> 
> So libvirt does not probe the qapi schema for all possible parameters?  Why
> not do that once on QEMU boot up, then when migration is needed use a
> sequence of commands to make sure everything will be setup before
> "migrate"?  It'll definitely take a few rounds of QMP commands, but the
> core issue is whether there can be any real atomic issues of that.
> 
> Just to say, I still think having "option" is a fine idea at least, but I'm
> really curious on whether there's any real issue even without it.

Btw, one more thing to mention: IIUC libvirt shouldn't need to specify all
parameters either.  We have default parameters provided, now with Fabiano's
work we can even have default caps being enabled now, used to controversial
when being a cap.  Hence, I would expect Libvirt doesn't need to specify
all parameters (with/without "config") but whatever parameters it doesn't
want to use the default (e.g. being specified by the user).

When we can have more sane default parameters (I do plan to turn on preempt
and blocktime caps on by default for postcopy at some point, for example),
I think it's better libvirt uses the default, or e.g. blocktime may have
been disabled there.

Thanks,

-- 
Peter Xu


