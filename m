Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF7BEFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxrmJ-0005oX-M6; Wed, 04 Mar 2026 14:21:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxrmF-0005n5-31
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxrmD-00026I-35
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:20:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772652055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2lYVshqoIJNjHcys4qaXvywlhYWQ1KFfLvduXW1C8vQ=;
 b=ZRzPuTp7b0kcXVUuGN6ty3LGe7pyWq8kK5k1ILCB227rT2sJuGyS9Dq5VtHBAeI6asPOeX
 X5qFxKWDOE9/JzeTbQ3oefBv2UnaR4s1WLFQnFOF/014fioxgJLAAYOMDCnS5d5+ibjayk
 X85zEao6TYvLNAm6/jf9Mr+3eE9dI58=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ZdKxVELEP7qP59jsfQMfew-1; Wed, 04 Mar 2026 14:20:53 -0500
X-MC-Unique: ZdKxVELEP7qP59jsfQMfew-1
X-Mimecast-MFC-AGG-ID: ZdKxVELEP7qP59jsfQMfew_1772652053
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cb4d191ef1so948413085a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 11:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772652053; x=1773256853; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2lYVshqoIJNjHcys4qaXvywlhYWQ1KFfLvduXW1C8vQ=;
 b=H9dZH6QxMqJqbMFrC8Cb1rpwgUkgJk1ThOXdCVBDYhtcw9uUU3MTMIQul0gB+Oc87+
 kB9mw90YBImaN+AyTZySzMfY2O8py9Nr+/uMVFlGJihit2MnHkKuS2ZkYApSdNOxUnyv
 yOhRDabFwA4xp41mzZV/0F2OhejQh/kO8aumSt7pWBe02KcwvW/vOeCR94uk3LKftNch
 vU3qMOzVx/MPL87dIGxm8Ei6sJrPndeBAMsGkeXoCiRIirQca+yZ9tpIOZpvSbf8e/38
 R1U5PrlaoH2gb3bhAsGxak7xOJdMcS0uyggiXC+jKN5XcyDQDy6hNcN6BGRLMpt7Ozk8
 kRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772652053; x=1773256853;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lYVshqoIJNjHcys4qaXvywlhYWQ1KFfLvduXW1C8vQ=;
 b=ifV4Ac8Cjs+xC3Qlo8/EohmHAFmnaEelUW7EIsYjFPnmv6kh1n6e42+Wb623ud1VIy
 Z+41ojaKZZb0NcvrBQpkIsVhn/m54tNr7XjJ6xKyUJHmhqK/vkXpNpCLvX+fCeOtBwAw
 Upeb4yESrV1qeep/cIlr3asgIceiKTU/k1YuSRf0GoaF1+cMvjasHnPqK0d0d24S1Xk2
 vvmCnwNGtGfK6FNoagARqWCnONXXDWtlQlrK/k5jcGCvg4k3iUjbSKWMHkPhEX9Fhthf
 iSucGbaz/ho6uKYs9MYpoONU0D1GcdKnv9C806X97gZeBcmdS9GwKhLqT/cf27qc9FLf
 sQhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbcS3h4TIJVrPMzwmAUEZPBv2jb6Bf7fC8LqJsLYkJ01AApM8VVj4O9QWnHBbsicaxO844Ih2cmWs0@nongnu.org
X-Gm-Message-State: AOJu0Yw3dkD1jSZCERpWC5GhfQfFn+hi03jt6yRWyc7g9VWYJ5bZMIFA
 wDiTrpBuZ9rstBEsxLyLD0dVvC7B/HRQIC0KOz+FGfUAc9r5vRyMqWEOv7IS/Zt5F3iS/3P899S
 fop2buPiOLfXH8YuhHFJwXkdiedkWIN0NtZ4H0n/ooLViudABxedTvtyi
X-Gm-Gg: ATEYQzx9RPkWt4u83AHf+FcSbt7yglf8yKm85lq23kRHBfthhuP7VQoO6GJOsMPsz2w
 2b16ICZiZ/fDf3v2ZhWgKjHeF+qMFkmcB7lng8GhKxKjw1hMjH3OXFjqLsO45jzDew0rgCWhi+L
 k7sJekCnp/3uue0Rv2Zb0yXGyF+m8pF9D4+OqJektQ1jUg52uxxqVRFbb01yUtbLS6cHfrq93Ff
 AuKFlxAl3YrAs+p4GSAnLCzj9NBib8NukIyWXAiBDJMhfSpxFlqIWJ9XNz9e3TiOHljjBPo3afo
 /NFOJzqXD5nRnabMBWGllJYVtXZChCMKTLkSYQga0aZxtzNeD7IVSn9RFwNS4svcM4rLVP89a7V
 ngv7DWVtKowO/xw==
X-Received: by 2002:a05:622a:48e:b0:4ee:428e:bf0f with SMTP id
 d75a77b69052e-508db243ca8mr42273691cf.2.1772652053060; 
 Wed, 04 Mar 2026 11:20:53 -0800 (PST)
X-Received: by 2002:a05:622a:48e:b0:4ee:428e:bf0f with SMTP id
 d75a77b69052e-508db243ca8mr42273251cf.2.1772652052617; 
 Wed, 04 Mar 2026 11:20:52 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449874b7sm155788991cf.9.2026.03.04.11.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 11:20:52 -0800 (PST)
Date: Wed, 4 Mar 2026 14:20:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 16/16] migration/vmstate-types: move to new migration
 APIs
Message-ID: <aaiGCalvQNX3WQxl@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-17-vsementsov@yandex-team.ru>
 <aacS1YUD0xesMufw@x1.local>
 <842c669b-21f0-4a17-bf4f-f2723f0e5466@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <842c669b-21f0-4a17-bf4f-f2723f0e5466@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Wed, Mar 04, 2026 at 10:15:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> The only problem is that we don't have error_append() function)

I definitely wanted to type error_prepend() when replying... :(

I think it might be better when putting upfront / prepend, say, the
original error should look like this, which is weird to me:

  "XXX != YYY NAME"

(maybe even no space???)

With append (when doing that, we may also want to add a comma and some "0x"
prefix?), it can be:

  "NAME: XXX != YYY"

-- 
Peter Xu


