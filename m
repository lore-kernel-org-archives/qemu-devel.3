Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD95FCD5BCF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smF1I-0006p8-Nm; Thu, 05 Sep 2024 12:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smF1F-0006jP-IA
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1smF1D-000611-Md
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725552454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jp345HzFmHJEwidIfoXQdHcIH1v2W8J0QUu4Wb8LVnY=;
 b=hjWxxkBWJakUQ9TJEJPc023hFtTfGI3R8y7CP97SWwwFuwA4LugUUZkpnz25Dt2NGa4aSV
 9ZjjznoDlCNLZ9RU9dDMK8yYYROSOUZL6y9Lgcvwt7LLk/atS6Bd0nPpwB97W4cDMnYJg9
 GZt1qeVzon3JTycn1NjaKaaD3NqWoak=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-OmmHIVYhNAKCFrVPrhXAdQ-1; Thu, 05 Sep 2024 12:07:32 -0400
X-MC-Unique: OmmHIVYhNAKCFrVPrhXAdQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6c35b2ccf3cso14979836d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725552452; x=1726157252;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jp345HzFmHJEwidIfoXQdHcIH1v2W8J0QUu4Wb8LVnY=;
 b=EW4A7wTx4kltPz+1PsdINqoweprTDSYZ5YHo3EY3fPM/w5EuvBApA8FfccHiDRyqtv
 NTtQVtpoKz8kYSVPQrbK4GPUy81KpQj/arQRDDvrkBoLG1L+9t8bB9+b2BeK5h1suYum
 LISV0hKbGsijgeI9tMnoK62C8fFijTRQtXHGEImZftjx2ggex4IlykDuggQIPmFkSnzx
 v4tP77uYzZS2M8AaGOjW0KRL4xts8bhJ0IEmj3TlBi8hmgPX7DQFUlUEMTv273PmyTYz
 Y/8FPOREAx7/ft7Ilc0l98tc9Oj6pLCaS+8OejllwCd1Q7VMFI6bPEukzbSC8xYklEdd
 bRvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwODAX6TYFVE8doISLdfOSQT/rOjiUnjEUhk9162uiNOtSkjPv6VEZ9zaRUU5hkOeDWNds/+WGFRZ/@nongnu.org
X-Gm-Message-State: AOJu0Yx0r+n9o48px77i5kc4GNv4JleibvRjcJ8CMtmi/RTstTqZFLEN
 ia060aXt92JPeo3+CqgOoR7nEgi1K43nSmiv0fFsL4JpeAXkQO8goAGUUG/ZeGfRLY+DK9sp4LR
 ssXURUEr1MskV4pCSHmZaxoFlq6GJplt6RnTbmpoDdi7Qoe/I05qW
X-Received: by 2002:a05:6214:4413:b0:6c1:77ca:66e6 with SMTP id
 6a1803df08f44-6c3c62b3173mr102113946d6.32.1725552452187; 
 Thu, 05 Sep 2024 09:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9oPe/vTAgFoL/H+kQAEzNzDMUJyoURSRMXRDN3RUKtP81UDTLVH45WHx48Puph7mxqvbWDg==
X-Received: by 2002:a05:6214:4413:b0:6c1:77ca:66e6 with SMTP id
 6a1803df08f44-6c3c62b3173mr102113566d6.32.1725552451795; 
 Thu, 05 Sep 2024 09:07:31 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201e42a5sm8659686d6.36.2024.09.05.09.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 09:07:31 -0700 (PDT)
Date: Thu, 5 Sep 2024 12:07:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, andrew@codeconstruct.com.au,
 andrew@daynix.com, arei.gonglei@huawei.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com,
 den@openvz.org, eblake@redhat.com, eduardo@habkost.net,
 farman@linux.ibm.com, farosas@suse.de, hreitz@redhat.com,
 idryomov@gmail.com, iii@linux.ibm.com, jamin_lin@aspeedtech.com,
 jasowang@redhat.com, joel@jms.id.au, jsnow@redhat.com,
 kwolf@redhat.com, leetroy@gmail.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 mtosatti@redhat.com, nsg@linux.ibm.com, pasic@linux.ibm.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, avihaih@nvidia.com
Subject: Re: [PATCH v2 01/19] qapi: Smarter camel_to_upper() to reduce need
 for 'prefix'
Message-ID: <ZtnXP3_nB0vS5Ts8@x1n>
References: <20240904111836.3273842-1-armbru@redhat.com>
 <20240904111836.3273842-2-armbru@redhat.com>
 <ZthQAr7Mpd0utBD9@redhat.com> <87o75263pq.fsf@pond.sub.org>
 <ZtnTxNFmgJlaeLZy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtnTxNFmgJlaeLZy@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 05, 2024 at 04:52:36PM +0100, Daniel P. Berrangé wrote:
> On Thu, Sep 05, 2024 at 07:59:13AM +0200, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Wed, Sep 04, 2024 at 01:18:18PM +0200, Markus Armbruster wrote:
> > >> camel_to_upper() converts its argument from camel case to upper case
> > >> with '_' between words.  Used for generated enumeration constant
> > >> prefixes.
> > >
> > >
> > >> 
> > >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > >> Reviewed-by: Daniel P. Berrang?? <berrange@redhat.com>
> > >
> > > The accent in my name is getting mangled in this series.
> > 
> > Uh-oh!
> > 
> > Checking...  Hmm.  It's correct in git, correct in output of
> > git-format-patch, correct in the copy I got from git-send-email --bcc
> > armbru via localhost MTA, and the copy I got from --to
> > qemu-devel@nongnu.org, correct in lore.kernel.org[*], correct in an mbox
> > downloaded from patchew.
> > 
> > Could the culprit be on your side?
> 
> I compared my received mail vs the mbox archive on nongnu.org for
> qemu-devel.
> 
> In both cases the actual mail body seems to be valid UTF-8 and is
> identical. The message in the nongnu.org archive, however, has
> 
>   Content-Type: text/plain; charset=UTF-8
> 
> while the copy I got in my inbox has merely
> 
>   Content-Type: text/plain
> 
> What I can't determine is whether your original sent message
> had "charset=UTF-8" which then got stripped by redhat's incoming
> mail server, or whether your original lacked 'charset=UTF8' and
> it got added by mailman when saving the message to the mbox archives ?

I didn't read into details of what Markus hit, but I just remembered I hit
similar things before and Dan reported similar issue.  At that time (which
I tried to recall..) was because I used git-publish sending patches, in
which there is an encoding issue. I tried to fix with this branch:

https://github.com/xzpeter/git-publish/commits/fix-print-2/

I also remember I tried to upstream that to Stefan's repo but I totally
forgot what happened later, but the result is I am still using this branch
internally (which I completely forgot which version I'm using... but I
found that until I see this discussion and checked..).

Please ignore everything if git-publish is not used at all.. but just in
case helpful..

-- 
Peter Xu


