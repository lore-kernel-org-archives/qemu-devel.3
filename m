Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A398D3E77B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 19:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTQEr-0002Wp-AO; Wed, 10 Dec 2025 14:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTQEp-0002Wc-6Q
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 14:52:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTQEn-00035D-Fi
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 14:52:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765396356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GhKM1ZeTh5R7TsBxRL7JvSwRmzCGZ55//WeovnPEQbk=;
 b=aKfc0TT6ui17VADqNzLECvzvyDrxb5RvkiCzFA7dHY5YwszmgCkHiEMfjwH6AHlDxFbTI2
 p70CoMwA77y7lLv3lVYnjjKXWeQtF6JVDI6TaC6G7C8dLd7VmOf7mzm4C/jYz7vaTAHJh8
 Znn9qeSct1jgg91gsFvpuQQ7O9QjKxk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-ZJuWGqnzNBSVUmfsaYrt7A-1; Wed, 10 Dec 2025 14:52:34 -0500
X-MC-Unique: ZJuWGqnzNBSVUmfsaYrt7A-1
X-Mimecast-MFC-AGG-ID: ZJuWGqnzNBSVUmfsaYrt7A_1765396354
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b17194d321so33792585a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765396354; x=1766001154; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GhKM1ZeTh5R7TsBxRL7JvSwRmzCGZ55//WeovnPEQbk=;
 b=qGl6snINVGwwp7Iq7iNDjdkZJO5+EduFJO8QqnPsb4rPtBCOWS0XBaiDzs/WYtOv1n
 A+MSv/vJIiKH6Xc/Nu5TFT6qivxWz6sNPHStgQokzM0natCmgjCo1CjXlxvvbuV37gk5
 NFyGmMynJXLkzcki62Es7oLNJQ86IxmXgxrhKSt2cYnzAAduIbGYuoIbMUF4be6A6ccM
 YXQmExkEAbR6uwpoUdcbKqoAvH2ln1n/pjrBqtWYylzrr9ESANQ94r4+bXBfejbgSify
 wMn70ANxRxjSjVWVxyaXBtQtg6srPeqBxluIpHu5uh84igxs39A/VIpnoONEGNAeAK1I
 qVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765396354; x=1766001154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhKM1ZeTh5R7TsBxRL7JvSwRmzCGZ55//WeovnPEQbk=;
 b=qJdx9Eaod/sqDxUGMV87B8PaRVX/di5zce5TznPdfD7D2hwkT/QGOOU1DcmO806gmm
 uZJ6Y+XDfvOJqz81mYXSIeaGKlM1aNw36+6KMOt/uQ5ASpGK67P5Xjvj6DaC1oWLg16O
 5YL8xmYVU4Z7od8Ehz8slhlOD8eADmc5+NEHnUiAiAySHTCa4pwUIZVhgRKxkKQcBH8X
 f0yT+bhgfSKzO4d31UWqKtot/UHMyjUQXFNth9gAuHaKGesa6UnIzbstwLiYc9GM+m8A
 qxrjfawEWDSqMDLxGasuvmN1+HzhL72VWb/OxkTWagJ58QyMd83io0gyf+/5LUdVlg0q
 frIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXc4mP9Su60OSXSX2mWUlvCAalxdDk9obtpc44pVKYa3FYGOFZ+gLfIWyWueQgAsbEsUoPXobSH2TXL@nongnu.org
X-Gm-Message-State: AOJu0YzNtX98qg5+RfgsDfPZmMj4yMPp1yL+dEixMZ8XGkIxdtI5ZXwv
 a7lPZzszO8BeJ5tyZpRlF2jOPMSGZaufSDGcuL6hE/YYoAL3VZUoXirGdqZDuha8U4z13GWsGvV
 vY39LSZMIPOdAgYYegAs7+STppY5FeTfi8RxyLYYMTMcYKN5Od68uAcYY
X-Gm-Gg: ASbGncvNMCdsP3ZdrqZZ1KaCK2Qiiuiko8GcOe8uTHs5ZOYoMBbT7mDM0oLy2+bcIdP
 PCFfChaBX1HJbxkVvAT5bCmF/FYOlMrIqEKd1JPAeZzlvxbBYUxqZMXRVvirkYXfrekyrnSPmTs
 niB4AvzAliBi8VlH1yhe5Uf/Dvb9cz+yru3eVXXaIb1GRKq6K1IOZ/fArqX9u75awRz0Dxt6+Is
 fIFfY6nyudFLuXfOZ1yHYvJhxPcOJhWuO1IPotZxRdXiTg1ZfaHxudSHOzSgbmaxtq/SN0hlZfv
 wqRunfbAu5ClI350+p+GchwtvWGYByak0J2kTkiYhUh3YXHg0uRarE/0G8SUqEIZd/wDAs7gfaX
 Xi6w=
X-Received: by 2002:a05:620a:488d:b0:8a3:cd9e:e40e with SMTP id
 af79cd13be357-8ba3b503481mr544368585a.86.1765396353532; 
 Wed, 10 Dec 2025 11:52:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNg01LTTD2xKC7ny9F68NoNzPH+fJ1vJ1UqpLjlHXPf/PI1204zZ5KgCqRlfqsEkmPPMZTzQ==
X-Received: by 2002:a05:620a:488d:b0:8a3:cd9e:e40e with SMTP id
 af79cd13be357-8ba3b503481mr544365585a.86.1765396353035; 
 Wed, 10 Dec 2025 11:52:33 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5d3e325sm29643685a.41.2025.12.10.11.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 11:52:32 -0800 (PST)
Date: Wed, 10 Dec 2025 14:52:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org, clg@redhat.com,
 mark.kanda@oracle.com
Subject: Re: [PATCH] MAINTAINERS: Update reviewers for CPR
Message-ID: <aTnPfzO-u8WY8NpF@x1.local>
References: <20251210143624.416697-1-bchaney@akamai.com>
 <87h5tyjkv9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5tyjkv9.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 10, 2025 at 02:40:42PM -0300, Fabiano Rosas wrote:
> Ben Chaney <bchaney@akamai.com> writes:
> 
> > Signed-off-by: Ben Chaney <bchaney@akamai.com>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 63e9ba521b..dc6235e174 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3118,6 +3118,8 @@ T: git https://gitlab.com/vsementsov/qemu.git block
> >  CheckPoint and Restart (CPR)
> >  R: Peter Xu <peterx@redhat.com>
> >  R: Fabiano Rosas <farosas@suse.de>
> > +R: Mark Kanda <mark.kanda@oracle.com>
> > +R: Ben Chaney <bchaney@akamai.com>
> >  S: Supported
> >  F: hw/vfio/cpr*
> >  F: include/hw/vfio/vfio-cpr.h
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

queued for 11.0, thanks.

-- 
Peter Xu


