Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF540CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 20:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5rOI-0002tr-QN; Mon, 06 Oct 2025 16:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v5rOG-0002tc-JG
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v5rO9-0005hZ-Jp
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759780847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkVeycwXsxrj/EacDrgACCPtuVj8VrJ3JURKgNP1zP4=;
 b=KTqSwZkZyDCvizmE/eM80cvbA3g6cs8EqOgaeA19wjJeyyy9XDf4KQF8KWuX75EBP893az
 PpPMSHqCW70zJe/Ngn6hZo8j4K7VCkeqCFHZZ6QPQORQkA3uxj9+M+TzNBMei3MmvIxFEd
 w2tPKvsowKeHUFUOwRA2rXiwJgJE8ZU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-B8zcyWdBM8eqAmNvJJafHg-1; Mon, 06 Oct 2025 16:00:45 -0400
X-MC-Unique: B8zcyWdBM8eqAmNvJJafHg-1
X-Mimecast-MFC-AGG-ID: B8zcyWdBM8eqAmNvJJafHg_1759780845
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-85709cdfab5so1104855785a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 13:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759780845; x=1760385645;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkVeycwXsxrj/EacDrgACCPtuVj8VrJ3JURKgNP1zP4=;
 b=Ipw71ssHbnNTLt+HD30cMrSv35ZMxqfB7HRVF1qoEclZjXHO73Rav9lDG/VkRRNjbp
 5f9SPMqHK7S80kJShGw1ZEBa31u3ksEFL7sWtBbA5WZSI+pz29b2ECHBwr+uea/RgEzJ
 q3LeUnBc6AIAWeghUlq4psCIGCQifGJHU98huPVLMStQzKw6jubyAhQvAQGg8WAAgzEU
 l3kIjEODls4NB6CMpe/qw0wpJrWOuB2TxMq1Qktrr0kP+2Bfu85p2nN8Lyhd7pd+FubS
 U+WKI1BMctrNkG1tcE8fH+N3FRBs+LnB4wxEPl+eIvhDknwip7b6M4wcKOSm0fhvRZld
 bckg==
X-Gm-Message-State: AOJu0YzmrrhxmJxHXGqMp876RIMI5G6MWJ5jdLC3rnqqdoyngC/N+fD/
 MB6gOdoaP5auIcWHJ7TqsVdnEaQXHdrMtkCJDmPje210a6UDnkA/nD1sTomUSwGfIo+wzCiuTg/
 ddf2mxm9EtMtfOjAHD1kdv9fP7zPmDGwVSCppmOEl87bpcTSlnTaxnk/O
X-Gm-Gg: ASbGncvYuvcmgDkr72S3B5jxc0K27wivyHOlOgIxyaAaljFQkaDMOudPdNZXWEQwQzq
 Y95M0nVYFDxUtujIiIfifwcuv+uDbmXcy8GHX2t+6X3CZTFDrkonvu5g26dAhErb4nsWpnDOeMl
 GB6jyMr4RpaIrstoJcQVm/Lwp5zpDEIwG1LABd1BAhLjLGSGik9S7Ig60ILkL5u772oSQGaLRKi
 fWacUxiwddzb/lIYoL7KFi2X69oIEc8RLi0LDWYYtRUYaLRGqesJKkU3hJVjeFItVWR7upYsrS+
 jNUoDIBiln0d9LGTn4dX3uveYso5px9T8gfirw==
X-Received: by 2002:a05:620a:3908:b0:846:1789:c1cd with SMTP id
 af79cd13be357-87a3adf32ebmr1741843785a.70.1759780844697; 
 Mon, 06 Oct 2025 13:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESHxyln/CevO1JhoN82304pKgTtDYBG1wVW/xC21qq8bxD11RhdK9liazHaxorG3fZj6eEqg==
X-Received: by 2002:a05:620a:3908:b0:846:1789:c1cd with SMTP id
 af79cd13be357-87a3adf32ebmr1741834585a.70.1759780844057; 
 Mon, 06 Oct 2025 13:00:44 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-87779799114sm1372348085a.55.2025.10.06.13.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 13:00:43 -0700 (PDT)
Date: Mon, 6 Oct 2025 16:00:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] crypto: propagate Error object on premature termination
Message-ID: <aOQf6dO27T4zGQd3@x1.local>
References: <20251006190126.4159590-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251006190126.4159590-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Oct 06, 2025 at 08:01:26PM +0100, Daniel P. Berrangé wrote:
> The way that premature termination was handled in TLS connections was
> changed to handle an ordering problem during graceful shutdown in the
> migration code.
> 
> Unfortunately one of the codepaths returned -1 to indicate an error
> condition, but failed to set the 'errp' parameter.
> 
> This broke error handling in the qio_channel_tls_handshake function,
> as the QTask callback would no longer see that an error was raised.
> As a result, the client will go on to try to use the already closed
> TLS connection, resulting in misleading errors.
> 
> This was evidenced in the I/O test 233 which showed changes such as

Oops..

> 
> -qemu-nbd: Certificate does not match the hostname localhost
> +qemu-nbd: Failed to read initial magic: Unable to read from socket: Connection reset by peer
> 
> Fixes: 7e0c22d585581b8083ffdeb332ea497218665daf
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  crypto/tlssession.c |  8 +++++---
>  io/channel-tls.c    | 13 +++++++------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> index ac38c2121d..8c0bf457ad 100644
> --- a/crypto/tlssession.c
> +++ b/crypto/tlssession.c
> @@ -569,8 +569,6 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
>      if (ret < 0) {
>          if (ret == GNUTLS_E_AGAIN) {
>              return QCRYPTO_TLS_SESSION_ERR_BLOCK;
> -        } else if (ret == GNUTLS_E_PREMATURE_TERMINATION) {
> -            return QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION;
>          } else {
>              if (session->rerr) {
>                  error_propagate(errp, session->rerr);
> @@ -580,7 +578,11 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
>                             "Cannot read from TLS channel: %s",
>                             gnutls_strerror(ret));
>              }
> -            return -1;
> +            if (ret == GNUTLS_E_PREMATURE_TERMINATION) {
> +                return QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION;
> +            } else {
> +                return -1;
> +            }
>          }
>      }
>  
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index 1fbed4be0c..70fad38d18 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -368,6 +368,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>                                       int flags,
>                                       Error **errp)
>  {
> +    ERRP_GUARD();
>      QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
>      size_t i;
>      ssize_t got = 0;
> @@ -384,13 +385,13 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>              } else {
>                  return QIO_CHANNEL_ERR_BLOCK;
>              }
> -        } else if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION) {
> -            if (qio_channel_tls_allow_premature_termination(tioc, flags)) {
> -                ret = 0;
> -            } else {

Would it be simpler to set error only here (and also we can have an
explicit error message for the premature termination)?

No strong opinions.. feel free to use whatever version:

Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

> -                return -1;
> -            }
>          } else if (ret < 0) {
> +            if (ret == QCRYPTO_TLS_SESSION_PREMATURE_TERMINATION &&
> +                qio_channel_tls_allow_premature_termination(tioc, flags)) {
> +                error_free(*errp);
> +                *errp = NULL;
> +                return got;
> +            }
>              return -1;
>          }
>          got += ret;
> -- 
> 2.50.1
> 

-- 
Peter Xu


