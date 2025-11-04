Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67146CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGGf-0006sC-Uk; Tue, 04 Nov 2025 07:36:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vGGGe-0006rV-7O
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:36:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vGGGX-0004D3-7g
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762259758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5MHTJnkdKp5lFO3+UjSL6dV4AD70SZhsWOnY88YlpQA=;
 b=dJOLH3demzzp39uT3XW+QvQIQT5fe69w3S1IKC8BSMbN7ZVp2AnjOabYLH8zY+Bu5is0ZW
 9Nunl/CObDthGvBVYyhC6j2Wps9JD+HfHxrVrZHlzM9YIaN9VXuwVpyj/NpVFgjhM3V1YI
 +ykd7Ti0SZu3RWK8YiG64NLcKEWqpr4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-wv1KdExYODyNQA3PfdwH4w-1; Tue, 04 Nov 2025 07:35:57 -0500
X-MC-Unique: wv1KdExYODyNQA3PfdwH4w-1
X-Mimecast-MFC-AGG-ID: wv1KdExYODyNQA3PfdwH4w_1762259756
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475ddd57999so55622415e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 04:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762259756; x=1762864556; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5MHTJnkdKp5lFO3+UjSL6dV4AD70SZhsWOnY88YlpQA=;
 b=AhOTOH0uW1blIEwAMWD+8Tp+01FXn7QVL9rrgYAvdg3skVp+wwdRTlnsXuwuTFFOiE
 pMOtOP6y6pKUxfI9WAeDKu0seV7SoTOd7NnUQxw0hE+psr5lrcyMK9dLsa3OFfmQUth7
 eiOuxijkz+EyeTQHSIfLn+BDPCsA25IJuYQpHWyX4ORUhz9bjzz9n49i5DpnrbkKhXoK
 d4lJ336wkpRTVcZAhb/o9G0UkvdOLN22IJQo4TeMgLSGH2fff/BS0H4fLmAAkC7f1Roh
 1lNibmNb9/HIa1ZAogLsoXHB6s2LrmIIKMocCzPNZPsf0Inw9BtfZ1nKt58BVlPj+Eqv
 YaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762259756; x=1762864556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MHTJnkdKp5lFO3+UjSL6dV4AD70SZhsWOnY88YlpQA=;
 b=r9mKKcgOd55Gdw39u7QFRuFiZEqbmsYNNO7ZAvRul7IIMgzDev3NBg7O1W0o2lIbNu
 VaSM9rQDZWiwoAYxq5Ev8wXRQtrC4+PAm8GARZLdJCgQgHBYaoguYwwDhUG2RwnuGjAA
 14+xLGh76+qGA8scUwcn8sy8YorLSXv+p4hzqDhnB0wJkXVsQ8slESh14JtG8cX9iPWI
 qBCOhib+TcZQogBVOB7lilwQzjwAsAfuy9Lc4omQybnsno0u3c5XxmBj2Bc1VKK7FICF
 qXRmXgyFQ5taugOkR0xD+2i7c7TVcUWctqFfw5tkMlckr1K0k4B1cmTRzLgFzTRenY61
 pwGA==
X-Gm-Message-State: AOJu0YzqbiPIByDMzbEqVS/PiKo3MQBKSMSXjec4xz17tEVthKQiuXYj
 y7wYKcqkKzf3+tlK2DOMzFn3NN6kb7KFdeWJTJb5UHDg6ilkpMSykaLJv3iJdOcGSyPJ8bV18fF
 UCogOtgeUojYvWfhAffNs2NdNJX+OemmQbU9xPIEv8oIdp+74wACeRhUA
X-Gm-Gg: ASbGncsOGMROCPnSKsJH9mWBiPCYbrWFVrT0nByXFGtZPzJRdbPs/LNgTVAjjd9z/gP
 +9rPY0PWUtG20qXrTEHnrv/WhpIMm1Xj6fsId2gekfUv+spQnrCAi3wgnfFPYCN7QHyDLSOi1Bk
 8FjQK7wPTNiMm63jGmn/bVdGw8Md4q5TEM9UIC2v5bAqzmjTSJo09QktPBUVZPLBMyvGcPPw4Ed
 K+7yFKu8/JP8Kng7jTKPcn6ie1MQPoKT4/KOVDJaUNf2ghGBPV+7eL6Y7halwbbfIJa5YJIxVw9
 97StjkqgJkVtT1gwXqb8BJKx9VE3x8DdUPcagE+yoE+n99kIMsrgDn/UcbejVW7j
X-Received: by 2002:a05:600c:4f51:b0:477:59f0:5b61 with SMTP id
 5b1f17b1804b1-47759f05d3bmr7446145e9.2.1762259756284; 
 Tue, 04 Nov 2025 04:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYN7+Av9KfkNbtyVXVSKdQglAUQuoCie+YRQvhwedodR4V6OgMhC+NsI+1+ak18wYOlg3cMg==
X-Received: by 2002:a05:600c:4f51:b0:477:59f0:5b61 with SMTP id
 5b1f17b1804b1-47759f05d3bmr7445885e9.2.1762259755830; 
 Tue, 04 Nov 2025 04:35:55 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383b75sm260269585e9.11.2025.11.04.04.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 04:35:55 -0800 (PST)
Date: Tue, 4 Nov 2025 13:35:53 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] tests/migration-test: Check error-desc after pre-switch
 cancel tests
Message-ID: <4r5wbhkkk346usjdgvnc3epcom3he3y547p3smxbkvvnk677tz@e4hsizwn5sfp>
References: <20251031164956.3409661-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031164956.3409661-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Peter,

On 2025-10-31 12:49, Peter Xu wrote:
> error-desc should present on dest QEMU after migration failed on dest when
> exit-on-error is set to FALSE.  Check the error message.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/precopy-tests.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 57ca623de5..5f02e35324 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -759,6 +759,14 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
>      wait_for_migration_complete(to);
>  }
>  
> +static void assert_migration_error(QTestState *vm)
> +{
> +    QDict *rep = migrate_query(vm);
> +
> +    g_assert(qdict_get_str(rep, "error-desc"));

I think it would be beneficial to also check if there even is
"error-desc". That way if the "error-desc" is missing, it fails on
assert with SIGABRT instead of SIGSEGV inside qdict_get_str().

With this change you can add my:

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 5f02e35324..87e33b8965 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -763,6 +763,7 @@ static void assert_migration_error(QTestState *vm)
 {
     QDict *rep = migrate_query(vm);

+    g_assert(qdict_get(rep, "error-desc"));
     g_assert(qdict_get_str(rep, "error-desc"));
     qobject_unref(rep);
 }


> +    qobject_unref(rep);
> +}
> +
>  static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
>                                             const char *uri, const char *phase)
>  {
> @@ -784,6 +792,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
>  
>      wait_for_migration_status(to, "failed",
>                                (const char * []) { "completed", NULL });
> +    assert_migration_error(to);
>  }
>  
>  static void test_cancel_src_after_status(void *opaque)
> -- 
> 2.50.1
> 


