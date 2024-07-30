Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAE1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYlDD-0001wg-60; Tue, 30 Jul 2024 07:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYlD9-0001v1-1S
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYlD6-0004o2-CT
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722339603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qw14AdU0IXkpDivkGDV6hZVwfnXND3nPDL+cIqJ+6jc=;
 b=LPM4jPb6gm9WYOKSC8yVHZsD9+adxGv65obQGKXRt1Q0xzTtRsvaGrYm9Wt4xEZvBDcQ+L
 4VIaHRvp6XA8tYgIuST7sNx+FECe2qIMDPOqfv4Suq3xQ9RVeQqkafo7lNsyirmuXecf+P
 hIhEeGys1aFX/TbxNZAeqwD1zN1+K0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-k_1lnzHfMeaTjl9aNcxuCA-1; Tue, 30 Jul 2024 07:40:02 -0400
X-MC-Unique: k_1lnzHfMeaTjl9aNcxuCA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4280d8e685eso26647975e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 04:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722339600; x=1722944400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw14AdU0IXkpDivkGDV6hZVwfnXND3nPDL+cIqJ+6jc=;
 b=UKby0z0WC/rjObXHd/cXmOBXcOep4fqpc7BIkVzv8AH5J/Fe+Jjc+pZjTip8H1Uq1m
 oIaNRaU/em6xTsqTVW8lOHp+jyLLb8K0jxjqiIUu3TzzJCLNZLqTgRpwapR0O17Xq05X
 PqYOSVXwB/a2WaLaS84iVrXDAMNTM7CrmRBEMr3Tnq60uEsmk6J51xb9y2EkbQNA9tqH
 8CwxZ+0mkbu9Sl7J41j0K2DQVHFGQ+aWTzNEjPyCiF+/8b3FJSRbilVCfCNajDMegY70
 waDjhd0wQfjmlGA/FmNZZ9WYqhqxMFYXcpo/9zxZu6Ed9R+2mivEzs5qPlQDh+nM6xVh
 HHOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFKQ4Y8fKUy5QKRd+ymkys4/6u+SzqNVqZNm9hnMGh0VJ+ZKHrD1WzAXYzKN3tp49lVCHVoLPqyLw4oyVWGVi8ZBLT5E=
X-Gm-Message-State: AOJu0YyCqPq66vYzwnoMzgf4UapnpZsoAjZUmlwBcjK7FlGS8UzmV+pv
 YlMvldlJ+ACopK1K1IomMLHfnQJMjATghmq9DYLZU2bejrosGKCRJ7Aumy29dz87tInkYBLCQ7q
 R/mz+GmfHU8XrwAEW990k0VR6cd28+SDida+lf0aLVfw8tkWVOnaV
X-Received: by 2002:a05:600c:a01:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-42811d9f21fmr74743845e9.16.1722339600165; 
 Tue, 30 Jul 2024 04:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFDSiowIsoSZwXWb1/LWT1LaH1yX/TTS+tMiitrnLbmv78WhrySevPnWnQFwWtCBbIGKcFbw==
X-Received: by 2002:a05:600c:a01:b0:426:602d:a243 with SMTP id
 5b1f17b1804b1-42811d9f21fmr74743725e9.16.1722339599679; 
 Tue, 30 Jul 2024 04:39:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42819d9a007sm90598075e9.1.2024.07.30.04.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 04:39:59 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:39:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Manish <manish.mishra@nutanix.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, John Levon <john.levon@nutanix.com>,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 bob.ball@nutanix.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
Message-ID: <20240730133958.1a3ff13a@imammedo.users.ipa.redhat.com>
In-Reply-To: <96caae6c-5263-4b66-ab72-65f34dc63c17@nutanix.com>
References: <20240724075226.212882-1-manish.mishra@nutanix.com>
 <20240724110004.389c1a0c@imammedo.users.ipa.redhat.com>
 <21ca5c19-677b-4fac-84d4-72413577f260@nutanix.com>
 <ZqDh2NIE2ELRcwq6@lent>
 <20240724145432.6e91dd28@imammedo.users.ipa.redhat.com>
 <ZqEW/TIZAqLN3CKI@intel.com>
 <20240729141839.44203b6c@imammedo.users.ipa.redhat.com>
 <96caae6c-5263-4b66-ab72-65f34dc63c17@nutanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 29 Jul 2024 19:42:39 +0700
Manish <manish.mishra@nutanix.com> wrote:

> On 29/07/24 7:18 pm, Igor Mammedov wrote:
> > !-------------------------------------------------------------------|
> >    CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > On Wed, 24 Jul 2024 23:00:13 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> >  
> >> Hi Igor,
> >>
> >> On Wed, Jul 24, 2024 at 02:54:32PM +0200, Igor Mammedov wrote:  
> >>> Date: Wed, 24 Jul 2024 14:54:32 +0200
> >>> From: Igor Mammedov <imammedo@redhat.com>
> >>> Subject: Re: [PATCH v1] target/i386: Always set leaf 0x1f
> >>> X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
> >>>
> >>> On Wed, 24 Jul 2024 12:13:28 +0100
> >>> John Levon <john.levon@nutanix.com> wrote:
> >>>      
> >>>> On Wed, Jul 24, 2024 at 03:59:29PM +0530, Manish wrote:
> >>>>      
> >>>>>>> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> >>>>>>> to 0xb by default and workaround windows issue.>
> >>>>>>> This change adds a
> >>>>>>> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> >>>>>>> case extended CPU topology is not configured and behave as before otherwise.  
> >>>>>> repeating question
> >>>>>> why we need to use extra property instead of just adding 0x1f leaf for CPU models
> >>>>>> that supposed to have it?  
> >>>>> As i mentioned in earlier response. "Windows expects it only when we have
> >>>>> set max cpuid level greater than or equal to 0x1f. I mean if it is exposed
> >>>>> it should not be all zeros. SapphireRapids CPU definition raised cpuid level
> >>>>> to 0x20, so we starting seeing it with SapphireRapids."
> >>>>>
> >>>>> Windows does not expect 0x1f to be present for any CPU model. But if it is
> >>>>> exposed to the guest, it expects non-zero values.  
> >>>> I think Igor is suggesting:
> >>>>
> >>>>   - leave x86_cpu_expand_features() alone completely  
> >>> yep, drop that if possible
> >>>
> >>>       
> >>>>   - change the 0x1f handling to always report topology i.e. never report all
> >>>>     zeroes  
> >>> Do this but only for CPU models that have this leaf per spec,
> >>> to avoid live migration issues create a new version of CPU model,
> >>> so it would apply only for new version. This way older versions
> >>> and migration won't be affected.  
> >> So that in the future every new Intel CPU model will need to always
> >> enable 0x1f. Sounds like an endless game. So my question is: at what
> >> point is it ok to consider defaulting to always enable 0x1f and just
> >> disable it for the old CPU model?  
> > I have suggested to enable 0x1f leaf excluding:
> >     * existing cpu models (versions)
> >     * cpu models that do not have this leaf in real world should
> >       not have it in QEMU either.
> >
> > If cpu model already exists, you'd need a new version of cpu model to
> > enable new leaf by default.
> >
> > For completely new cpu model, it could be enabled from the start.
> > i.e. workflow for enabling that should be the same as with CPU features
> > (or as you said 'endless game' of copying base model and making it look like
> > should be according to spec,
> > but that's the process we currently use for describing CPU models).  
> 
> Igor my understanding was that there are two type of features one is 
> real CPU feature, yes those makes sense in CPU models. But on other hand 
> there are features which are emulated ones i.e. kvm-*, these make sense 
> enabling regardless of any CPU model and we usually use machine types to 
> enable these. Does not this features makes sense in 2nd category.

I'm not convinced that it applies to any CPU model.
I'd say it's risky to expose new leaf on CPUs that don't have it to begin with.
Also what about AMD cpus? Do they also support this leaf?

> 
> 
> >     
> >> Thanks,
> >> Zhao
> >>  
> 
> Thanks
> 
> Manish Mishra
> 


