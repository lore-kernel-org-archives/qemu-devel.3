Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC769EE36AC
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqa8U-0001Ou-9G; Thu, 12 Feb 2026 12:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqa8S-0001OH-Ld
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vqa8Q-0008KE-V7
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770915945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXEfTu58Iy5OOvLPRCDi2+eb0Xvt8YCk50Cuao7YiUU=;
 b=NW0/pJfMUDb1ElAEe2msta3sgfu7H/EhyyIDY8otBt7bN8NSFSN7Z4+NrE7Df0rG0lNkm7
 VYSA1V4B5i9QHirzNbpEVQk2Fu7DtklQ7L54QA0tCO3H1M7ryQI4TrB4el8KvkuQGPn0Du
 935oYcgFMQR7dlXLEOA/eB9Kz+xu+s8=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-DYOn2ojnMpq5kP8UxGJMMQ-1; Thu, 12 Feb 2026 12:05:43 -0500
X-MC-Unique: DYOn2ojnMpq5kP8UxGJMMQ-1
X-Mimecast-MFC-AGG-ID: DYOn2ojnMpq5kP8UxGJMMQ_1770915942
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-948357563a1so53346241.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 09:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770915942; x=1771520742; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gXEfTu58Iy5OOvLPRCDi2+eb0Xvt8YCk50Cuao7YiUU=;
 b=No4NMBcGSzPzZPKaWP0TyIwXJrJWuzMnVGWo+lBg3d8+6ciS8BdwNsFwRV0CSWH7su
 iNY4PnYIFTY11ShbdfwuIyU/+kX3OKT/Nr/8xrzOyWdkfgL7ji47vwN8WCROIXbvF9vb
 RtSpVFH0Xmm4eOjCiTYbgkWKB1RkLX2GA/qjSjOZi9wkukAcjWWxMMM2LgI9Ol0jduEN
 kcFjTemR1MsbaM0LteK7x9ZCkJNkdi3zMW973CcqtNGwXkyjQElhuk/pZo+tr/9Gb1Wv
 tNrJ5ntnXZ54oRixPKp9tUbIicV1uAna1j1dH4LPCV6BK8/M6eq62LWAbDzF0rikD5sQ
 zADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770915942; x=1771520742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXEfTu58Iy5OOvLPRCDi2+eb0Xvt8YCk50Cuao7YiUU=;
 b=RzQXlofywIE+9ZL/j3lPDZvYsmZgPZYg2+deNiZ6r6++bfnozQHQgBWBKYo+455M7j
 KPifDMgI/xSNNSGGF3XFwviCGnNNtTE8cKa3Uli0e+mlX7HGiBhjmmqDdwA6ueMwtLEt
 bpP01/cNA9YdAAlJSWHOD3vTEHf4NmtDtdkmmpFu4jDrs+1p5wQ6A4WkzB28btBmAmuv
 qRkmLx0n1Gh4TgdMueWZmJzL9yJrb3yKW4/ScEJQAFf8WYUZ3cniOv+AW+WAOHbzJYOq
 NpNYrkn7JgFmLPeMB35HaPbuhWhIXJWzJcrU492VWuKefzf792Rg5jcy2iwhF0VZq515
 SDuw==
X-Gm-Message-State: AOJu0Yy9BS93F5hdQVRdFBAJrlrb7PklGx8qBbIac5JXrmDovTzQW/iy
 V2tGWS5I6rc9sQ9HGWOX3HBm8PSPqnlL9mPR+pjpl9zpiyfpP67bfmthojo+i/mbSsZ4FIILxEa
 wJ8Zw0G+N43Z1+2ml0xBXG/nDStHHWIXriztvEAbs2wCY1HpH+dvVtynt
X-Gm-Gg: AZuq6aLgmtDjTIxwJoqhrTx9TovgcIZHpWOEAvUlr2Q32O3IlEzOhkhMx//xustybsm
 eYAZyBvMvYPOysyVdDBvHXPhCvN1mpFm1nrVMcBczJREwB1LwOqrADs+hqirQGSQDl8s3269UU6
 3IPTiKN/3lsDoSSH+MbtYBqFEUDBDApg4kRsWS5vZ31OnCTa9XL3TMEPkdvZrRzBrkwUgPYikpU
 jg1ERUvVUAShYC9r0yD2HumPZaHfJDH819D6S/pMhVSQkQ2sPm0m12F4htAFjKQuAgbqRYG13Fv
 3pY6t9yf4CpDoSjoiUDlrPB8sk2qVMV2pWGyH6HscccyTavp224+6uv6vSkFyiYmeX7mgEEgpjT
 I1zE5EVAc/6TLsg==
X-Received: by 2002:a05:6102:3f07:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5fdfbb95275mr945914137.24.1770915942175; 
 Thu, 12 Feb 2026 09:05:42 -0800 (PST)
X-Received: by 2002:a05:6102:3f07:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5fdfbb95275mr945873137.24.1770915941659; 
 Thu, 12 Feb 2026 09:05:41 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cd8a5ccsm42770476d6.25.2026.02.12.09.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 09:05:41 -0800 (PST)
Date: Thu, 12 Feb 2026 12:05:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] tests/qtest/migration/tls-tests.c: Don't use tls_psk end
 hook for no_tls tests
Message-ID: <aY4IWncKW_itrxDg@x1.local>
References: <20260212114747.1103466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260212114747.1103466-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 12, 2026 at 11:47:47AM +0000, Peter Maydell wrote:
> If you run the TLS tests under a clang undefined-behaviour sanitizer build
> it will fall over like this:
> 
> ../../tests/unit/crypto-tls-psk-helpers.c:53:12: runtime error: null pointer passed as argument 1, which is declared to never be null
> /usr/include/unistd.h:858:48: note: nonnull attribute specified here
>     #0 0x62bd810762ee in test_tls_psk_cleanup /home/pm215/qemu/build/clang/../../tests/unit/crypto-tls-psk-helpers.c:53:5
>     #1 0x62bd81073f89 in migrate_hook_end_tls_psk /home/pm215/qemu/build/clang/../../tests/qtest/migration/tls-tests.c:101:5
>     #2 0x62bd81062ef0 in test_precopy_common /home/pm215/qemu/build/clang/../../tests/qtest/migration/framework.c:947:9
> 
> This happens because test_precopy_tcp_no_tls() uses a custom start_hook
> that only sets a couple of parameters, but reuses the tsk_psk end_hook.
> However, the end_hook runs cleanup that assumes that the data was set
> up by migrate_hook_start_tls_psk_common(). In particular, it will
> unconditionally call test_tls_psk_cleanup(data->pskfile), and
> test_tls_psk_cleanup() will unconditionally unlink() the filename it
> is passed, which is undefined behaviour if you pass it a NULL pointer.
> 
> Instead of creating a TestMigrateTLSPSKData struct which we never set
> any fields in and requiring the migrate_hook_end_tls_psk() hook to
> cope with that, don't allocate the struct in the start_hook. Then
> there is nothing we need to clean up, and we can set the end_hook
> to NULL (which the test framework will interpret as "don't call
> any end_hook").
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


