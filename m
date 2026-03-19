Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685031090231
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3E5J-0005Ld-9M; Thu, 19 Mar 2026 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E5C-0005L9-Q8
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3E58-0006SS-OV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773929437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a+80GO4Uum0Eaou5aju8Hc4jms2TLJCe4zZBaYgxF/E=;
 b=cbTWH2lFHu3J2aQjHBeD/AzZuLBbhvw9j3grYn82EKFJf6NvUC/WyUlJ0CWVR3kjjsH1aV
 JzaKJUewV1w2pTzmv0AJTGA96ZO2lSHJfpCU1AhUYQSrSvXq7PlojpqNnSdOBh62LSQgQs
 1ZiH7ACcI3InKNylJB4FtsofHE1SGjs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ixHPBSQsOOm5gFRJJa7vjg-1; Thu, 19 Mar 2026 10:10:36 -0400
X-MC-Unique: ixHPBSQsOOm5gFRJJa7vjg-1
X-Mimecast-MFC-AGG-ID: ixHPBSQsOOm5gFRJJa7vjg_1773929436
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-899f474fae1so189629036d6.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773929435; x=1774534235; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a+80GO4Uum0Eaou5aju8Hc4jms2TLJCe4zZBaYgxF/E=;
 b=Rr618eVt0WRARyXFBMEqtXBQfyeoH2tMgfSEPuPekuXukHSr836Nx7k0KxYiUIj2On
 T+ItAzco0o518ZVCmMRZS0CdVgZ5SSnFW4e6Ww4R4MUEWmHa+uOwAeFT94zmJNSdDnsU
 XXY5cuGYnWyCQfCgZFGh4n+fTatRek+geMjaLxOuVFwA0SyaL+HWymgJIqPO8o3boHmH
 0dY/iRjU/ONvSVaoIFNx1+kKCS8ZcQMEGenBiPButtt5CUNfRFvy7W3Q/XgA0nq2vxBQ
 iSuCP0HFa7I0dMl+jks6Lua0cK+i3gT2+6ELvUvQ7Mo1mbklo53+EkSAXXo8lo/VAUCx
 4TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929435; x=1774534235;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a+80GO4Uum0Eaou5aju8Hc4jms2TLJCe4zZBaYgxF/E=;
 b=mNyp8ox28KU3TOi3MGoSOcUxjrpgnTMOawZloJ4JjjAsYIkktx0SMXJR2vhibP3rY1
 xfE+y2Rb+8U0iyh0quPO2zKmpwkTJO1i51/5NWXDMFH50aIaYVnzoKVPoI9MedzIzgIS
 HqCUJmjmq1hKWhMnARwjCJrbuIVOkLCgtcz7baV11VpyVHTvuNewMxK8hkH3HKtHPvB7
 CRCD8fbEAKgWbd7pT6awvaBcRAUGiQXhWhatxTTOu+aUnG7HFONgQuM2hDevJ7UACx38
 MDhkpXeZmKrB86xwpwrqIBYQWviEJH1UJOunTtoOllq432qNHIW+3TuHQnCPlyqgw+a2
 nLLw==
X-Gm-Message-State: AOJu0Yxu4gYoPC4Px1yCqiAaLCpe912womuvBjz+cUF3apfEIDJVCTeI
 g2ClcmU5NahVxa2H0BPuzkCY6w9oEN0Wb4kS7oGd+y5PSj3t6SLKn87qlykNlSX8auaikm1HuQT
 gdXrVmQb2NmGxZhS454JGZVXO13RDML2btnwomVdXRpr4ArX/yGbPSxEJSObMOd+Y
X-Gm-Gg: ATEYQzzWsPgSeSqJ9yvw4Kz1yxi/WPOVsu7Na1WzjvaXtQuUrCJQygLkQLdj5a+RnGW
 YI+BWenj2qfCn6Azl5wrV+hX4XmqDpw6H28ov7i0oVHp4AhgY8KrRwm1WZJvsKKIzAfjbWAf2Sk
 J9Kn/Vv/gPplC/L1TrzN7k6aKztSEuRV65Nrop1xBY3sg9cNmRfwmkVBmlBbpmRm+Ftez1DX4V/
 w8xRrZj7vhWnB2zoftMpmrxTAtT9h05xYdX7scKafPQ9cytv3+oKUEz+tVmLzFDyeTbB+Py2iBp
 4JjmdFD0ARJzPZMIT1KvqRJb8DFjLxWRUfbk7tpDJQRaqyvtTQe6yZg5prEffKMVEsoFWMBYC56
 WuooqNmXPRO90ow==
X-Received: by 2002:ad4:5765:0:b0:89c:50fb:31c0 with SMTP id
 6a1803df08f44-89c77403fcdmr46404226d6.10.1773929434990; 
 Thu, 19 Mar 2026 07:10:34 -0700 (PDT)
X-Received: by 2002:ad4:5765:0:b0:89c:50fb:31c0 with SMTP id
 6a1803df08f44-89c77403fcdmr46403526d6.10.1773929434369; 
 Thu, 19 Mar 2026 07:10:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c6b913e46sm46336976d6.21.2026.03.19.07.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:10:33 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:10:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH RFC 09/10] vmstate: Implement
 VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Message-ID: <abwD2N2UhDfSnFYV@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-10-peterx@redhat.com>
 <CAJqdLrpXBDJ4SxCBjiO6wtQebK+4N8Z-2Yj2_A7J8PjGtha34Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqdLrpXBDJ4SxCBjiO6wtQebK+4N8Z-2Yj2_A7J8PjGtha34Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Wed, Mar 18, 2026 at 11:00:02AM +0100, Alexander Mikhalitsyn wrote:
> Am Mi., 18. März 2026 um 00:23 Uhr schrieb Peter Xu <peterx@redhat.com>:
> >
> > Introduce a new flag, VMS_ARRAY_OF_POINTER_AUTO_ALLOC, for VMSD field.  It
> > must be used together with VMS_ARRAY_OF_POINTER.
> >
> > It can be used to allow migration of an array of pointers where the
> > pointers may point to NULLs.
> >
> > Note that we used to allow migration of a NULL pointer within an array that
> > is being migrated. That corresponds to the code around vmstate_info_nullptr
> > where we may get/put one byte showing that the element of an array is NULL.
> >
> > That usage is fine but very limited, it's because even if it will migrate a
> > NULL pointer with a marker, it still works in a way that both src and dest
> > QEMUs must know exactly which elements of the array are non-NULL, so
> > instead of dynamically loading an array (which can have NULL pointers), it
> > actually only verifies the known NULL pointers are still NULL pointers
> > after migration.
> >
> > Also, in that case since dest QEMU knows exactly which element is NULL,
> > which is not NULL, dest QEMU's device code will manage all allocations for
> > the elements before invoking vmstate_load_vmsd().
> >
> > That's not enough per evolving needs of new device states that may want to
> > provide real dynamic array of pointers, like what Alexander proposed here
> > with the NVMe device migration:
> >
> > https://lore.kernel.org/r/20260317102708.126725-1-alexander@mihalicyn.com
> >
> > This patch is an alternative approach to address the problem.
> >
> > Along with the flag, introduce two new macros:
> >
> >   VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_UINT{8|32}_ALLOC()
> >
> > Which will be used very soon in the NVMe series.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Amazing, thank you, Peter!
> 
> Except small nitpicks I've left as inline comment in this patch, it is LGTM.
> 
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Also, I've rebased my NVMe series on top and tested everything
> locally. No regressions were found.

Thanks for the quick review and update.  I'll wait for a few more days
before a non-RFC respin.

[...]

> > +/*
> > + * For migrating a dynamically allocated uint{8,32}-indexed array of
> > + * pointers to structures (with NULL entries and with auto memory
> > + * allocation).
> > + *
> > + * _type: type of structure pointed to
> > + * _vmsd: VMSD for structure _type (when VMS_STRUCT is set)
> > + * _info: VMStateInfo for _type (when VMS_STRUCT is not set)
> 
> nit: probably these are outdated now
> 
> > + * start: size of (_type) pointed to (for auto memory allocation)
> 
> nit: I guess we need to drop this line about "start" field.

Yep I'll fix those, thanks.

-- 
Peter Xu


