Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D3DCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFX5-0003qo-7p; Thu, 18 Jun 2026 12:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waFX3-0003qQ-H8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1waFX1-00034j-H8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781799833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFYnEj2ilmREVMhXyeTp/CXiclz1mJrVueMpOWcmTnE=;
 b=b0GAZE8BjzB92AEUvxJoiZuUVLa4TY5jm6vgwplR65eycMLEWHTacDrZ9kz7tnsuqilBua
 th9g24OMMzqcSme+KEXlilTY7MRlTcMUL8keQIVFkiC1Lb8EdRQS/pou+aj5Ri7UbHbRFD
 ifq29Y+nAJAqq7SnvNVk2T0ygRggTXE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-1yKpMkIHM-OoMoBmali9zg-1; Thu, 18 Jun 2026 12:23:51 -0400
X-MC-Unique: 1yKpMkIHM-OoMoBmali9zg-1
X-Mimecast-MFC-AGG-ID: 1yKpMkIHM-OoMoBmali9zg_1781799831
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so1245683f8f.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781799830; x=1782404630; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iFYnEj2ilmREVMhXyeTp/CXiclz1mJrVueMpOWcmTnE=;
 b=PGsaU707mDs02pAC5+SIeUX+tGe5B0y6Ttc1itrov09iBlgtPpLwopDeRMbamSCxLV
 fzxihCuM4SC0+pApNw0tJYmNpiPuc7od2ZDr5Vb9044IeaA5Cxtrd/AxPElQaJNoyXya
 fryWss67XfjBPcrZfL8aNpwTQsmFXlKgSHp6GbVHUbgR+GGuxK9FefyJ1k29gjotayMw
 cnGuCWmpcdOw/qkQriJ1RmegsPNwU8SlD2Vv7t4DIsFvoaPVPa9oq4wJs7IF554XChQz
 dZ4V1lWDIi+SWEEa0l5bTZChJGIPdTzuOW1e8L1R6NABTWD9m0Q+b4Y8L8l1q9kRfppw
 LW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781799830; x=1782404630;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iFYnEj2ilmREVMhXyeTp/CXiclz1mJrVueMpOWcmTnE=;
 b=mpd3EUdVbpPkeyUylkwjCssRSH/tqxcZmQ5LuEWfu+kOVOVpZNdeyoVgGLaGL8ooOb
 qFTLXP6TL42VE57K3OCnhVZiigaO6elHy1TERTlwfKXD6VeBX+iVeDl2iN6y6Yl+Tce7
 xr21tFmTsZoNwRdFWMF6eTMXTnzjiYh3xzQTz6LEorSegngi81bWEUvHa4qUUnImKlFf
 xEx3p/p92EyK4Q8y9EddZrIED6a82RJP5wDF83JNJbfc0c0A1WTCcts4/yapNamAkfKa
 ro0dgN4X+JNmcNFgoPx5WQuUySyQPwEeowrsYfgOnb3wQKzU6fPywPChL+bXaBFXPs6s
 H7bQ==
X-Gm-Message-State: AOJu0YwUmCGdzuMlXwU97r98S4uK5eHrw3WEP1H9S39PbovMVEiLJNQk
 U70IPO/3wXAejo/47hKqtE/HfIesDJMNq2Qtbge8IfrrEc2zEH0ewJHJ8mXbMNgRK2I0wX48OyZ
 b63+eMMniSBcCangEnK6q4oOCjsCLh6AuVn+e4ay2+lsHHvwMvqThDqdr
X-Gm-Gg: AfdE7cmQMg/FniqQ+qL5pPIMmS+OV1TCqgov45VseZuekDNlNyATppqfp1J+1HDNNqG
 lb7Uf8efu4O+H1aK5IA/mdZuv1D1DL7HLjRGOwql33r5UUDdhu5nGstCcYRNZWBvWCeqv4qq8yX
 pVq9YJTM2fCIBDyC/wbaWTiVios6A2WSubw7pjGFnn95B8hX6OT1+EExRfOJI14/LQoux9k2ltU
 Kvs+czRriLwnBCdnciHetqvFHimwtTXkN8/0WLILUAyRLjdhDbeaBYzlIpE2IkKRBj+EVMwMrv2
 7OImjM93UMBxXvglMTli5euTENjtCDOaVM/Ikdl/YkYjwjAy7mwuU8izO+uF9z0Pvpo3nY39UJO
 8Q4lPkCz/geCtXobWUIyka691ftySEGzi
X-Received: by 2002:a05:6000:2382:b0:45e:f2e1:9a20 with SMTP id
 ffacd0b85a97d-46501d44e00mr273200f8f.27.1781799830357; 
 Thu, 18 Jun 2026 09:23:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2382:b0:45e:f2e1:9a20 with SMTP id
 ffacd0b85a97d-46501d44e00mr273120f8f.27.1781799829787; 
 Thu, 18 Jun 2026 09:23:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46508a04d22sm55636f8f.8.2026.06.18.09.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:23:48 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:23:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <20260618121520-mutt-send-email-mst@kernel.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618112415-mutt-send-email-mst@kernel.org>
 <ajQXrpKNx4NnhUKa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajQXrpKNx4NnhUKa@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

thanks! sorry probably just me being dense but some things
here I don't get. might be worth clarifying:

On Thu, Jun 18, 2026 at 05:07:10PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 18, 2026 at 11:30:29AM -0400, Michael S. Tsirkin wrote:
> > > + * The maintainer(s) will develop and/or review patch(es)
> > > +   for the issue privately, optionally attaching work in
> > > +   progress fixes to the GitLab issues.
> > 
> > attaching how? how do i ask reported to test the fix?
> > was easy in the email flow.
> 
> You can add arbitrary attachments in gitlab issue comments.
> 
> > > All patches must
> > > +   include the issue URL in the commit message(s).
> > 
> > you mean the commit message of the patches I presume?
> > there's no commit at that point.
> 
> Well I presume the maintainer will have a local git tree
> with a work-in-progress commit.

sorry I don't get it.

what does it have to do with patches then?


who cares about my local tree?

and why is this mentioned twice?










> > > The
> > > +   **"Workflow::In Progress"** label should be assigned when
> > > +   a maintainer starts working on a fix.
> > 
> > That's a bit heavy, and what is "working" anyway.
> > It's an issue tracker not a planning app.
> > Don't try to make it one.
> 
> Various "Workflow::" labels are already present in our gitlab
> instance. We don't use them consistently - this text is just
> a pointer that the're there.
> 

maybe "can be assigned" then?

> 
> > 
> > 
> > > + * When a CVE is allocated, it must be recorded as a comment on
> > > +   the GitLab issue, and the **"CVE::Required"** label replaced by
> > > +   the **"CVE::Assigned"** label.
> > 
> > Recorded as a comment how exactly, in what format?
> 
> In plain text.

yes but in what format? 

> > 
> > > + * The maintainer(s) will update the commit message(s)
> > 
> > what does it mean to "update the commit message"?
> 
> The commit message for the patch the maintainer has in their
> tree.

then you mean "before sending a pull request"?

> 
> > > to include
> > > +   the assigned CVE and issue URL. If multiple commits are required
> > > +   to fix an issue the CVE must be included in the final commit in
> > > +   the series, and may optionally be included in all prior commits.
> > 
> > And here, included in what format?
> 
> The CVE just needs to exist somewhere/anywhere in the commit message.
> It is common to put it in the first line, or with tags before SoB
> but it doesn't really matter as long as we have a record of it in
> the patch.
> 
> With regards,
> Daniel

Will be really annoying if any tools try to consume this e.g.
to decide what to backport.

I suggest deciding on something for these free text fields,
how important is it to be able to write ❤️❤️❤️CVE-1234💰🔥🎯 really?

> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


