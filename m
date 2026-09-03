Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0662C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BUi-0005fh-8z; Thu, 03 Sep 2026 13:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2BUb-0005bw-N5
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2BUa-00057p-2T
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788457490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bTPZYYSsxet6yu6XA2ZYmEwkI3qoy4aaimrBCx5z0Y8=;
 b=hmoefX/JhH8r7iL5HScVqa+bbdskx69zLYvQC0+nOm1aGuyz2+CM0+NAZwuzJtXqKk4fJT
 GNPwYK1sBcqzgYGqpICDoxhEZQpa8ukw2eKOdDNhMTna7JT2Ubb3zSZqAuNZUvcLJe9rKJ
 onNh3Dw1GnJLoRRGCnSPNTaM31sv1tg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-xmftedNkPqSWI_NjL77NyQ-1; Thu, 03 Sep 2026 13:44:49 -0400
X-MC-Unique: xmftedNkPqSWI_NjL77NyQ-1
X-Mimecast-MFC-AGG-ID: xmftedNkPqSWI_NjL77NyQ_1788457489
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90cc934fe9eso2362416d6.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788457489; x=1789062289; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bTPZYYSsxet6yu6XA2ZYmEwkI3qoy4aaimrBCx5z0Y8=;
 b=eOqMSH2fdk3jVBiHMalinWw2C/IdgRxv+kotc9wyXf7aYHmJVrU9nGRHVoSFSjQSNP
 P2IxIXE2ma1wwKU3SdDQJWSHLW718z314l4HCp4oVlC3GNvLOvmg8dxSV3ggJ5jsLWz+
 WNYcDLJe58ZAyy5q+eJEmpQ5Lr4XrNXMt7Ju5SBFt7Ip01EA2Us0nHPQeqj5ZeNj2cwC
 78vM5XR4efaAkBjraXMtIZ7IXwsUjvqxnseNTIMEwovVFTbIkAhVcMLJYeRM5Vd6MpNI
 S6tKeRA2Uxnkdr41YTWIbDwnFgRr4TPiGdoEROVENVC3wDUE4Lrd1bt693lqIU/JREqA
 oz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788457489; x=1789062289;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bTPZYYSsxet6yu6XA2ZYmEwkI3qoy4aaimrBCx5z0Y8=;
 b=FmQOaxYAi0okR/vpNmimn7eUhIpBe18KbS7w/IS8MLRHDgPPgoRmL8bQoelMkBw4bk
 6CO3cCttnR6MVjrWPusjq+pl/4BMMCJdHRPxeXbf98+LnvlXkt6qj3NUxvgkWoyL2C6a
 rqzcCmdDG+xDAN4OHK/kcgSZ3HpJNglRv1lNCdOEDuSd5iSeFu0wO3Pj8jIyjwsq7I8i
 zHClvWyldaQYBaEHjR3stnuJ3fToMEwnRanu0IMFcS9dwLADrkjMIIfi3sruzgG9aVMP
 04F5bGYPwEBZL+jGR4ez7pGf/wmoeAEGqBiYsmivtOv9+FbNaahSd0PQjVOb1L2DtdAP
 ysYA==
X-Gm-Message-State: AFuF++mcDBRLMS4Fr+UMHGuhxiA0f3+ly1HQA2RvBRH2gqA3AQEntAVI
 l9BpJdi1IJTdYRA6PhIORAjSgJOyxdY5WCM0/ILELg0nt/WLvKcCOODFFIG8A3dFGafxNbIixn5
 4r/MljG4zrnTD3cfpRwbDMOpVTuk9ok6bN+O1eyvAufPdMbvycKWLdtYO
X-Gm-Gg: AYBFou2sUTnLaz//aVLAygNZv/ue6mYEThC9mHMJp+LbuaACgQ0jSFzW+apOO/Oraop
 I0LftjDoEJ1VVYaCIKIetcY+HjVqnuQ4y284kQ3wOPxpAu/m/hzdzYenuEa/42DRUvjcl856cu7
 lepmOi03hcFHSF16AjI/bqfaIasDb2tQDhylPS768RhW9lIfeiMx5xse+ljdVA7pXpdGmMWbVWE
 uGdBe8BxoDfoZM97ExmUx6Lgw+8uwS3DJPofbMG8TO2wK5dQ9D9yKbyYWARQ+22OHiENaiPh34L
 OBsQPKJIj9CAh0IVRK5txAr1cEYUcxI6QcnM68PIktg20OzAFRPBAgEdC0wFFzTVZkrd
X-Received: by 2002:a05:6214:8095:b0:910:3451:b182 with SMTP id
 6a1803df08f44-9103efd580bmr10319166d6.35.1788457488719; 
 Thu, 03 Sep 2026 10:44:48 -0700 (PDT)
X-Received: by 2002:a05:6214:8095:b0:910:3451:b182 with SMTP id
 6a1803df08f44-9103efd580bmr10318516d6.35.1788457488130; 
 Thu, 03 Sep 2026 10:44:48 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9ee2678asm49198216d6.15.2026.09.03.10.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:44:47 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:44:36 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/18] migration: Rename variables in
 qmp_migrate_set_parameters
Message-ID: <apmyBF8W4brbz4c7@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902221547.1812481-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 02, 2026 at 07:15:31PM -0300, Fabiano Rosas wrote:
> Give the variables in qmp_migrate_set_parameters more semantic
> names.
> 
> s/params/input/
> this is the user input from qapi
> 
> s/tmp/new/
> this is the combination of the current parameters and the input
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


