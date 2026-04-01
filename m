Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE2A107639C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w81XE-0003bA-Hm; Wed, 01 Apr 2026 15:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w81X5-0003XH-Vp
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w81X4-0006QH-41
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775072835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+EACVHxm4XFoMukfu9NE733xrQI5QIC1pLcAZUZ/XbY=;
 b=g+ED3BsVZhelCyOzOYneKCPWEC/ZTXU1VNmz/n/i43pD4bBAvJw72xZRtvJGacxVwsa8Me
 dN28WW+VZmXORJxR0FpwIAzwU5bIDHfFeP8/GbxuRa/AY54PNpDg1dL3sPY6EL4WJ/k66I
 TeH1ssnoRvYd2N/Ri0RTze1fa3sfMuM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-fMugf3DsO1Czry3KS6R7qw-1; Wed, 01 Apr 2026 15:47:14 -0400
X-MC-Unique: fMugf3DsO1Czry3KS6R7qw-1
X-Mimecast-MFC-AGG-ID: fMugf3DsO1Czry3KS6R7qw_1775072834
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4661881eso1334311cf.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775072834; x=1775677634; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+EACVHxm4XFoMukfu9NE733xrQI5QIC1pLcAZUZ/XbY=;
 b=AmJLxlhNtOz4mRLjDM28+H2I/1ceqRNGnV2eAQvBVlzkhBxVDMt73ssRgxmlURB/7q
 DfVCS+5/wcLjggaj3ld3g7g67WE9vSmYx9bCV7UxZiV2VVRTW9IpqZnQQxJDbYFQVAdp
 46OZCE5STvWlRh0XcjnT2PevSHL0aOcXQ6Vgceu1FihI4pfH54iK4w9BVq8lncPV8nqs
 Jr3RDcKUB/cbJR+edEEZ+3SlnBBa7lyGg8bnuYa8xC3nns6b+LXGkIsh56AeR3r+6uz+
 qyuGSMd6NQOcEhZMTLzoseulVhrWjjCBn4MAn469ioPUB2FLvzO/sLq15EPOqNnlXdN/
 /t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775072834; x=1775677634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EACVHxm4XFoMukfu9NE733xrQI5QIC1pLcAZUZ/XbY=;
 b=YIlx2oAJHr/nUMcBjibu/ots5dTgFu4LC4pLqM94l7fNmx2pJfQXW8fOtinhFLbesh
 JVj1Qs1xddYiIh7TBWn1PQMP93szhbjg3oyB0Wp4wYAB/jOYSDgLUVmVlduACd5Td1td
 V+gHj92EU6AZ9YCj4knlNbugv1+KTW7YejD+W+0ZY19grGdVVdA6xAS5lTzy7OgC9wU+
 WfihKFAIVHqTHc5jBLgisAMTnc9+KzHRuJk4pAYobwOvoGtZd+cjjIr5T14vMtrFIlTW
 3iwwB7KMVjdPiK/SLv05wyp4fUXdu2E7r9DF9sqB9Toh8Lo5l9f2SHFqSqKfVBDDsxrl
 +/Hg==
X-Gm-Message-State: AOJu0Yzz8D7hyXjSTbTAHKGmwCpVxrBeKapkML1mJkFmc6GDr+RRAQu1
 n93VcYqvHMKrKF2fEPHgVpn7x8bWIUJXK9B2XuH0qD5PZl0yJyKtUYOmv14TRgUGHLA0VwjeuUe
 uua9bO9ZAa1xRT6zt0aMpCzGwtvC1FayORN0xfYLfDcTSWi+BNhk2cyba
X-Gm-Gg: ATEYQzye0TiU7IQh0TbUCU7oHeyVryhLYRpzlG1BT4zeugVuhGgtxuxLDviTN7gITVO
 zzVY2ey8DPBS/8vmTR2cTh4L9LbigFAguod6vFOsWnmomWccBkT2iX3aacpus0Qy4I4vZQH4JIQ
 1SMAzRKFTCcyThrAtcgcpMHgRewXBesTa5giGmRkmKamc3E97yZKfgqXgesLpu2oANcD1L7UK3Y
 LunsnfKrpI+8pAPuZQ38co/qJBr61k51TrOEGfKkqe8XPmn+gT/UrSFJwLpQs1HegpWmDvmWLgF
 gqPTRI7nPql3JceHeSUBRNMpiZUmuGQIcvy0OLHgPFn6PoGY0VJ7giMDMpv9DNIasBGBwYNEP6J
 fIqsy76w1U0key7Vf9yHrdhDhpnbJCJrNPzg4mbmAqi8dCw==
X-Received: by 2002:a05:622a:428d:b0:506:217e:b0e5 with SMTP id
 d75a77b69052e-50d3ba37cdbmr72729801cf.0.1775072833946; 
 Wed, 01 Apr 2026 12:47:13 -0700 (PDT)
X-Received: by 2002:a05:622a:428d:b0:506:217e:b0e5 with SMTP id
 d75a77b69052e-50d3ba37cdbmr72726201cf.0.1775072828628; 
 Wed, 01 Apr 2026 12:47:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4b73e7e5sm5028611cf.17.2026.04.01.12.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:47:08 -0700 (PDT)
Date: Wed, 1 Apr 2026 15:47:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>,
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, devel@lists.libvirt.org
Subject: Re: [PATCH RFC 02/12] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Message-ID: <ac12OtXu9Uk375Yy@x1.local>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-3-peterx@redhat.com>
 <877br7kn2p.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877br7kn2p.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026 at 07:54:38AM +0100, Markus Armbruster wrote:
> Recommend to rephrase to avoid the repetition.  Maybe
> 
>    # @ram: Detailed migration RAM status, only returned if status is
>    #     'active' or 'completed' (since 1.2)

I just noticed the previous document was also wrong.. it was too ancient
since 1.2, and we introduced too many new status that also reports RAM
statistics..  I changed it to below:

# @ram: Detailed migration RAM statistics, only returned if migration
#     is in progress or completed (since 1.2)

-- 
Peter Xu


