Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C0DE7718D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 19:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQAzA-0007mm-Vy; Tue, 24 Dec 2024 14:54:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAz9-0007me-UG
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:54:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQAz8-0000yX-9H
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 14:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735070068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5vtPSwGtH2ejIR+xC1v6/lc/0P3xJYSMhU1FknNePQg=;
 b=ctkdR5ewR4y8da3CM6NkPMXqWJ/Oy6aNMdG+RHfTZW4G0Yn6A65Se0SrdhSlF2582BhCz0
 oXmkpI3PF37xxvJRZ7llf+9cMN/WzZNLWH3YhohUu6DwEleETncWKx0VRmVlHkvTjy2rKj
 tCj6kxaaxNNzaCLa/adFuwlnHBX5Xl4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-2FY4H6TWOGeiGfYl9Z4Vng-1; Tue, 24 Dec 2024 14:54:27 -0500
X-MC-Unique: 2FY4H6TWOGeiGfYl9Z4Vng-1
X-Mimecast-MFC-AGG-ID: 2FY4H6TWOGeiGfYl9Z4Vng
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f0b1023bso61932566d6.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 11:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070067; x=1735674867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vtPSwGtH2ejIR+xC1v6/lc/0P3xJYSMhU1FknNePQg=;
 b=sXfY43vsZ4P1KG3sjZ8BlJiuNXKtnNok4Y2llKhSrQHYU8m1jufuFNEopBU2lRbVvu
 C8ZTqBaijb1b9yG5bAdaGTDl1an7sanwoXYVaxoJpB3pnih1GgnfJ1WofsEfIJmsW0Is
 IezCv0lS9vgO6778RZsvmNhCuZOk1nmXzy4LBVEINfeCLXXrqNAzCkdw/yShc5VBPaC6
 jKyoTfP8ehRyEJtWr6gQK8ZXM6H3Na8Wyxizxy5FJ70oL/LDMecSsBV1jdWSaP6HxG6l
 ls2Zn2xmuQQ3ZPDBwP5i0NRCTfsue5nvml9gM7Fm9hN/u0OLrrve4xtU0pwNiUgE2iZ2
 Xi/w==
X-Gm-Message-State: AOJu0Yx2I2zzJqqSL6YDJKNxcev/qzmo6Uq6E8hzlGpJ6zviUOimxyUA
 rRL8CxT/d4Gt43BhYZYt1gH01SWTbOuI4Mn494qi6HsVLXTWFbquBRbhTntxS3ji9ZAnT1RZQxb
 PbZD1DLwouiYM0oSA98R258Dd3ekaLv72fqTS9ZfTJCi6SJfL4oU/
X-Gm-Gg: ASbGncvA8SQh6tQGom+luz6pRfqcF4Qv6NCm0pKvNuYNGSzcXjprI8GMclCntsi8nki
 SZK+yjY8L2Qwy2WxQZHsst08xB/A/o5qNgnHHbkSsYcpH5Tp+eBtYJWLhTKRjqE5JAgt/UgeM+w
 tjbeH1UUxsQYJgGRD0mF1uFpSfGdMYGGdKsH7xREivelngZRlbI9rGlOKusA7rpMWK1/AmaK+fo
 2InQxoKMwK/pmqv6apq7v1n05lZ0fHvOG20C/gm3MwjSENMUwhkG8IHiKK1pgManuXfRkQ1cDSK
 aDby9wSO/iGovhSv5A==
X-Received: by 2002:a05:6214:2522:b0:6d8:b189:5419 with SMTP id
 6a1803df08f44-6dd23308e27mr290935206d6.8.1735070067057; 
 Tue, 24 Dec 2024 11:54:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGS1+RQpAm7vNbL3R+yw+EJynntwJgn2wVbpLM4W9ca97Ymv6DJA20KtjJpxpEgHwAjhOV/GQ==
X-Received: by 2002:a05:6214:2522:b0:6d8:b189:5419 with SMTP id
 6a1803df08f44-6dd23308e27mr290934946d6.8.1735070066781; 
 Tue, 24 Dec 2024 11:54:26 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd22f025ebsm47620176d6.82.2024.12.24.11.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 11:54:25 -0800 (PST)
Date: Tue, 24 Dec 2024 14:54:23 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 21/23] tests/qtest: assert qmp_ready
Message-ID: <Z2sRb-6ziWJ-FU6u@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-22-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-22-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 24, 2024 at 08:17:06AM -0800, Steve Sistare wrote:
> Set qmp_ready when the handshake is complete, and assert it when we
> communicate with the monitor.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  tests/qtest/libqtest.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 2f44d3c..43ee92f 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -77,6 +77,7 @@ struct QTestState
>      int qmp_fd;
>      int sock;
>      int qmpsock;
> +    bool qmp_ready;
>      pid_t qemu_pid;  /* our child QEMU process */
>      int wstatus;
>  #ifdef _WIN32
> @@ -552,14 +553,23 @@ void qtest_connect(QTestState *s)
>  
>  QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
>  {
> -    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args, true);
> +    QTestState *s = qtest_init_internal(qtest_qemu_binary(NULL), extra_args,
> +                                        true);
> +
> +    /* Not really ready, but callers need it to test handshakes */
> +    s->qmp_ready = true;

This is a bit ugly.  The patch defined qmp_ready to be "after qmp
handshake" so here it needs to be ugly.  However IIUC what we want to
protect against is trying to read() the qmp before connection (while
handshake may or may not happen).

So I suppose if we use that definition instead (could rename it to
qmp_connected if that's clearer), then set it to TRUE in qtest_connect()
should work for all cases, meanwhile provide the same guard for things like
cpr tests.

> +    return s;
>  }
>  
>  void qtest_qmp_handshake(QTestState *s)
>  {
> +    g_autoptr(QDict) greeting = NULL;
> +
> +    /* Set ready first because functions called below assert it */
> +    s->qmp_ready = true;
> +
>      /* Read the QMP greeting and then do the handshake */
> -    QDict *greeting = qtest_qmp_receive(s);
> -    qobject_unref(greeting);
> +    greeting = qtest_qmp_receive(s);
>      qobject_unref(qtest_qmp(s, "{ 'execute': 'qmp_capabilities' }"));
>  }
>  
> @@ -786,6 +796,7 @@ QDict *qtest_qmp_receive(QTestState *s)
>  
>  QDict *qtest_qmp_receive_dict(QTestState *s)
>  {
> +    g_assert(s->qmp_ready);
>      return qmp_fd_receive(s->qmp_fd);
>  }
>  
> @@ -813,12 +824,14 @@ int qtest_socket_server(const char *socket_path)
>  void qtest_qmp_vsend_fds(QTestState *s, int *fds, size_t fds_num,
>                           const char *fmt, va_list ap)
>  {
> +    g_assert(s->qmp_ready);
>      qmp_fd_vsend_fds(s->qmp_fd, fds, fds_num, fmt, ap);
>  }
>  #endif
>  
>  void qtest_qmp_vsend(QTestState *s, const char *fmt, va_list ap)
>  {
> +    g_assert(s->qmp_ready);
>      qmp_fd_vsend(s->qmp_fd, fmt, ap);
>  }
>  
> @@ -879,6 +892,7 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
>  {
>      va_list ap;
>  
> +    g_assert(s->qmp_ready);
>      va_start(ap, fmt);
>      qmp_fd_vsend_raw(s->qmp_fd, fmt, ap);
>      va_end(ap);
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


