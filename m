Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23807D6E2DC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJ2Q-0001n4-QK; Thu, 18 Dec 2025 13:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWJ2O-0001mg-3X
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:47:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWJ2M-0003KE-Mt
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766083661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgQ8kpxxGJE1hU5csZQaI4pAsfPNdp79D4czIHFZ/sg=;
 b=jFIxq9HGErlubIIGa4GZtSediac9WwvJbfvq65zYc9kEptfZEwuZ5Sa0fvxb2EQtDUo7sG
 4Y7Nz4R2TP9Xh9M80SugaETApNkCbWs14s1TZlaJ5wprSbMNN9X/dlvfNqm6OUtApn6W1p
 hNEwcuIieR0m/H4U/BNAtmUczNyVGyA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-qKmvtHnzMHyu3KkqKeRupg-1; Thu, 18 Dec 2025 13:47:40 -0500
X-MC-Unique: qKmvtHnzMHyu3KkqKeRupg-1
X-Mimecast-MFC-AGG-ID: qKmvtHnzMHyu3KkqKeRupg_1766083660
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88a2d8b7ea5so12291356d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766083660; x=1766688460; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XgQ8kpxxGJE1hU5csZQaI4pAsfPNdp79D4czIHFZ/sg=;
 b=lI1zdEyOO19/0CwPpwuHdHehqhZKgY0lmwzaZGZ8cL1Duw1g6QLjoURBw4UetH2Hqo
 MbZMyj5kVHeteuUqEg5+INJ7hnl3Lau4/+TeLoGbEP9s/siBOsmHle7dfsL41YkwmdD0
 vQbKUHBvL69yH2x0qxoGeOZQTIltzvJOCpxw3dedw2Iiun6mp9PIjKNC4YmSiWiiifrG
 5iWs6B6dTJWxGvjhiHLAHsXK++0w6OG7o+8oUHy2Sa9NWyXVvG+coPqqAtmq0kniSl1l
 0hB/FACiZbBKN0jCQhAFukLxYZmxXULp7c/xFvDc/VnXMAlyeK9/zzXphk5J1fO8k7F5
 hREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766083660; x=1766688460;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgQ8kpxxGJE1hU5csZQaI4pAsfPNdp79D4czIHFZ/sg=;
 b=Peoz7OMdJzF6yT1rb+zdyIKOnzS/n+mpDAMhsbfGiCRQ5h/Ua9WlCcyehGVD+yVnOP
 /qbcohKgsAPnYGRKuwPdbQMBqXHj8IchI5rkLR1SssnTCJNuVgmEJCi+RlEFSCm5962b
 5wpMlLbHgXJMmyy4djSao3lCSGiBRFyklyj4+wj6N1DAHdEf9FCGFEfEQZ5HDIjs0DEQ
 3WLgwjJwCtFaIEjT4TCfIdByAVVYW0AxPzUFP/3OxlcHIyhoCNQwWsZGSqe63MlsaTtN
 vEt6YDLXPeOg6KwifxKpx9pCmnUOY6FhMrAy3XFesKdwPjWZoBCSDmdJ0Ak8I+SMD4HL
 FwGw==
X-Gm-Message-State: AOJu0YwCBwg6H11JTlqbKqOxy5Ez6p6kZfvWiM/D6/crpOLjbj2CnvlD
 CApFRsAESrtE0hjf81qxsWV31wOyZLNwiQS73BppGnkuRd85qnbLbcZudejEktw0sFpxxD9flfw
 7/KAagdKSITq5OmoCTuJr0+fIn/sdpdti318LylI+dvAoI46PJKyy3Uxi
X-Gm-Gg: AY/fxX7q5JUYhRf5aytpO3O7PEf12iW004KkQDW/qYhDyZuzSenAfaQrpLlZNkFqEZp
 F31Y8GAxQWvTlUrHxhmXa2fRO5Iiw214Gadn51BXK4GXjcURURLQnvM6nRaOQyEvvQgqjd927oY
 Ys1YmlhrLFzhQxxaY84cR2WrgyXRPjSnyWUVQkPFxZ/irtqPqOMM9x2Y2tiAbBlyibNK+O5/lrw
 7nZm8okJ/5S0fGu/4n+5KBdmoNNBvPMbLU6eeltGlAKSEbe1Mu/8EbSrRtPlugV55FB7EYubkJm
 ampDVKV0DHXm1c+TGyBmQjiiw5ai/aOYjEd38i0LVulf6BLDBGlnxT5dzWIsW4orX8E32x7UBK9
 Q3es=
X-Received: by 2002:a05:622a:4d06:b0:4eb:a3e0:2fef with SMTP id
 d75a77b69052e-4f4abd608a4mr3424131cf.39.1766083659639; 
 Thu, 18 Dec 2025 10:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3Vmn23WdgTq8iguNh2lsK5VWqZgj7zx7X4+l0xEcle/xhupaB5cSpshjeBteJY2xvO+lyTA==
X-Received: by 2002:a05:622a:4d06:b0:4eb:a3e0:2fef with SMTP id
 d75a77b69052e-4f4abd608a4mr3423871cf.39.1766083659183; 
 Thu, 18 Dec 2025 10:47:39 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f35fda91c4sm20993591cf.31.2025.12.18.10.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:47:38 -0800 (PST)
Date: Thu, 18 Dec 2025 13:47:37 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 34/51] tests/qtest/migration: Use migrate_incoming_qmp
 where possible
Message-ID: <aURMSVKqFeaqP5c_@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-35-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-35-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Dec 15, 2025 at 07:00:20PM -0300, Fabiano Rosas wrote:
> Always use the proper function for starting the incoming migration,
> there's no need to call QMP directly from the tests.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


