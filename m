Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF177EDEBE8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUx7-0001t8-Bg; Tue, 03 Mar 2026 13:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUx5-0001rR-Kq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:58:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUx2-0003Fl-7W
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lWCfpJa5aO8MQfEWHtHA3ZCj3eg+k9D3nWLcP9erzd4=;
 b=XOBeDqo8iB9KCAnsnM2TMWIYprUw4BUYcwPh072ETTNCvCFfcnOk61ut8fK7N7iH/2Lhos
 G2Db6qZjnaBXyQ4cu/9UNu83uRtg8/e2Otohn6ZuqFhWz1sEf+sDCo3MvCvljd7YgxMS+q
 Xq06ktRAamqbLniz5BeK8rz/mPwIXG0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-EdoDqflKNO-3ZmLt8d7flw-1; Tue, 03 Mar 2026 13:58:34 -0500
X-MC-Unique: EdoDqflKNO-3ZmLt8d7flw-1
X-Mimecast-MFC-AGG-ID: EdoDqflKNO-3ZmLt8d7flw_1772564314
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cb4d191ef1so737486785a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772564314; x=1773169114; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lWCfpJa5aO8MQfEWHtHA3ZCj3eg+k9D3nWLcP9erzd4=;
 b=STCrv0A7t8cHGZm79E39XDSQY73aqO5uW6q6WX1Wq/1iyObGeBX7FEeLCZnC78wbhH
 4Cyvtq5mT9qBLlpTVRTwqQTgT9jiZp8e1zCkPG2Tdn34BVb28Z+csO7Y6wWkKhzQlcl8
 ZlMEf61Uijv3PqiOvMpFnZ2Q9O4JRWo79tkPjuNWuBRz8gMke1gKCsIkhvAeBBJW+3sJ
 9dkwUAk+vLqzkqtHkbEwDXJEfIgvoE3Fnhi2Qm6ebbL+lwPaZsTPOyu/1R+ExoFTdYdZ
 43KQxQcC+UEzUKQKjkDbSCxK5vcijVKX7526JMGmzCFtYoa6MyouUN7BfwAybCw7aRGd
 uGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564314; x=1773169114;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lWCfpJa5aO8MQfEWHtHA3ZCj3eg+k9D3nWLcP9erzd4=;
 b=h8jYhm8vsuKF+EgPhQJJ+QcD7KUgQMmM2zeARG/YjGnzonALxqwqrS14KRzCPBIlap
 +evOhr2ENFzRQmnE2sptZQFovlMNAQYw0yW2L8jc3emvXZQfhURlXRKGmDRPCICHDoFj
 RutFYKElcWMGkT4FkrZcCg7OoQRFXXx89MwlBNEosH5Kb6BIO/IARdq5gRVy7+sKB+AW
 Xso4oeRDDJYErEEKyi1kGERJY5g8K+zC0jXa405MeCCPTYmrc9kgjp7hOqPmhpDGB5sl
 KhYpEuypSgZj2YtirniZ8murzz/UDyKo7Dudx5Ul4kAirmbX8Dy4cqaa7lJyjk8KDTzx
 B+1g==
X-Gm-Message-State: AOJu0Yz5GMEXkc4Hikb9GTE6bVgtrZA5Qm5Cq64iIPLHtmXbMsJleKUT
 PmEp62o8PB8pLhmklBnoJ6EYa/EiJQ3Zg9q/wHkjO/SZ7/iESqjfw7lBQw1+44qmywVZ363fIBV
 fBmLSoXhYAvxkmGGvYXlZRtay5ZbQGWP/z8jaFCdd1W6ft6W8We28RleoIWl0DhKL
X-Gm-Gg: ATEYQzw9mSAK7wX1dSUBInLqnwXORP+7PuJ7S3FR9mqbenIu30WX5Zsu1rTu+xI4a2g
 a4LQPoXoD2TVfKNOgFYmu9b5tqBjtc/4Ab7VUVwt4u4b1+jghuf0WTteRmXV+1Sb6y7Cw68uiJo
 InmVCMLhxA/oYknRIcEa77Si7oMCBRKwS+6I77/2wglM2RjU48LYaqmaqlfL9yPTKg4wHQ+lxF2
 kSeuiGdkCUy8yoQK8P3ZWx12ShT4NEVP5V5ohBq43Tu0vU1hbYEvpT4TNJkDOG8913ZdEeQb3c5
 WDgWdrao//H2xFDnoX6dQ+T2bJ/FGb/MEK8ppK6PivSHx4gX8YEShG9QghP/Gew/RuJUS+G5RV8
 KiSsX5PyxYyH0UA==
X-Received: by 2002:a05:620a:2988:b0:8c6:a487:6add with SMTP id
 af79cd13be357-8cbc8e8641fmr2059333285a.22.1772564313662; 
 Tue, 03 Mar 2026 10:58:33 -0800 (PST)
X-Received: by 2002:a05:620a:2988:b0:8c6:a487:6add with SMTP id
 af79cd13be357-8cbc8e8641fmr2059329285a.22.1772564313126; 
 Tue, 03 Mar 2026 10:58:33 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f948dsm1445739785a.30.2026.03.03.10.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:58:32 -0800 (PST)
Date: Tue, 3 Mar 2026 13:58:21 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 03/15] virtio-mem: use warn_report_err_once()
Message-ID: <aacvTbkRZYcd4-XB@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-4-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Thu, Feb 26, 2026 at 02:59:48PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


