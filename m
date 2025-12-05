Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28426D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXUt-0006e0-Aa; Fri, 05 Dec 2025 10:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vRXUr-0006cR-TV
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:13:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vRXUq-0001eh-Hw
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764947603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Io4wfGITaWyRG4Kk8bVcs56o+uZjI0OfeinBQIH/d/E=;
 b=CuJeEouLVtwb/Lohy5AkrezWaFbGCAa69JXNVapzsd4LMqkLfZye9CIZIEaWldOOi2en0U
 bx7Svek09b+RwoQtReUumy7Mq5OuUO+NQTntEVsGk+eFQTr6kmolUNwPJP+7aT9qjlCC1a
 U92NBoR8U6bmB/ATJSeNhq7IFhxhi/k=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-QuRvtURtMDi5O8CZmtsamg-1; Fri, 05 Dec 2025 10:13:22 -0500
X-MC-Unique: QuRvtURtMDi5O8CZmtsamg-1
X-Mimecast-MFC-AGG-ID: QuRvtURtMDi5O8CZmtsamg_1764947601
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64203afd866so3749504d50.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764947601; x=1765552401; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Io4wfGITaWyRG4Kk8bVcs56o+uZjI0OfeinBQIH/d/E=;
 b=IODyUcg74JTgiN6jXAsp95CiHE8vbR3VLk0GTEFlVZQX2gRUxfo+/n3dWBwhHa5CUh
 pdRQ23RVQcJB5Fyb4+IfF2tuAHxfFesACHWGcI6x6u3t0de7zt6MAAU+g/3hMN+jmbi+
 BsxogWgM5jk/MwAZONpCV+JIQNvfWpK4VywS9jiRNgBDr3Cc+dTOR/6LyTdT+iFYc47J
 4CXI0JSWJD0KJqxnF450VRxlX2Xf/4VNdrjQaUMTTxNsBYvwPxfRr7+hjrDXF9YhRo++
 vsfZoUY3aNdRrAag9A9ytrxl4mcL0IdAd4z1RZiuv8RGOnXbaKg/JISH+zl3/SuQe2SS
 OKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947601; x=1765552401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Io4wfGITaWyRG4Kk8bVcs56o+uZjI0OfeinBQIH/d/E=;
 b=vn1+oWjgiSqOWdRSAzUHE/FS5/Mjnvc7N5nRYHmPb8CaPEdxb3Y3Ju+usu2yBNvUH9
 sObOFhuc9UYj5pxRUtozJapIn9HFm2ghW30Yw4CD+EdLKrzv+aDJsAhLkIHQVzY4rqlt
 gVSiAFTSroH2ROKOWip4O1lLL62V2ZBU5uMag7g3CG44TIFZgmf8FDY7dy1i7+ukr0l7
 sIOB5xxVkkj74kELUkurFR1OWzEl9t0NOsZDad6BqS2NV7Lx+WD1X5GR2XgJx/GQcteW
 +BMTwXz231EeZhWfbgtN9Zadx+YUutbdyV4/jq0zqdVjrXm5BFCX6BdR4Zjf7ynmb2k4
 oPEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8jgfFmaUrRlRfi6ao9/CWndEKF4WZU80YqAlDYUSV+I5ubnpMoOX5UO3OmhLubAIE0NXqVf8g3fcr@nongnu.org
X-Gm-Message-State: AOJu0Yy3KFNo7qlYapu1+MpMG164IZWNiDd3eTik2lJMgmdotG6tG1cE
 vQ4+Wwv0ozjr7kjJpnEj7vDvSGg+asEFu7ELZFD45SJQAh37bgO15xFm+yVi52YUd+6NGTdm0LA
 7E6+ZYreWkRppYPCrAOxiYMHik7N9bLuWaKBZd851UYMLm8NwehBDZoIh
X-Gm-Gg: ASbGncslr1bnAE7BJ8rA5LCmjrpwooWTT7zkkCLPRY3+qg8ezaKTCExeZRPO4ECW1ua
 dkmLNq0NlicSWVl+QwLINu69MAblcr4v8TJ7xOymIjcxrlS1VnAnr0Nedf/LbFMk/vlAk9Flfxi
 +oczdhMMd3JU1Y9QcBNf/y25C8fGDUIkgzL0PQLD0Dv/M6A+LZjuIk8VsjxP7nSWwsDpaW83UH2
 UUiTPU8/SqzvMvG6UF1E7WKRJasv8VcH/bABBElrZvA0tKGnvm0Bi80LOGi1WKdd56iQ1hQQ9wR
 hCto+Q9mwJvwweRuJueMlZEQxya3sd+m5yj+08hh7DqSIW1p88f8NR3cV+afOiu//WpW7RJyML/
 5AK8=
X-Received: by 2002:a05:690e:d86:b0:63f:c019:23bc with SMTP id
 956f58d0204a3-6443d738e0dmr4637512d50.27.1764947601584; 
 Fri, 05 Dec 2025 07:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzXoeqo6SIpemfFzVDMmALETcOdZK4ok4QlcNnX3zC5s/4kRaqgNf0gPHQi4bfKbna/CmqQw==
X-Received: by 2002:a05:690e:d86:b0:63f:c019:23bc with SMTP id
 956f58d0204a3-6443d738e0dmr4637473d50.27.1764947601107; 
 Fri, 05 Dec 2025 07:13:21 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b6252a01fbsm413659685a.7.2025.12.05.07.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:13:20 -0800 (PST)
Date: Fri, 5 Dec 2025 10:13:19 -0500
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "mark.kanda@oracle.com" <mark.kanda@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Hunt, Joshua" <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hudson, Nick" <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Message-ID: <aTL2j7PB4--w68ir@x1.local>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local>
 <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Dec 04, 2025 at 08:05:59PM +0000, Chaney, Ben wrote:
> > Considering unix socket itself doesn't really have a UID attached to it,
> > it's only the unix path that needs a chmod(), meanwhile the mgmt of course
> > knows both the right UID (as specified in -run-with) and the path, would it
> > make sense if the mgmt chmod() after it starts dest QEMU? That'll reduce
> > the scope of impact to minimum.
> 
> 
> I like this solution, but it runs into the issue that the main channel socket is not
> created ahead of time, so there isn't an opportunity for the management layer
> to change it's permissions. The CPR socket is created ahead of time, so we could
> use this solution there. I'm not familiar with the history here. Do you know why
> the sockets are created at different times?

IIUC the cpr channel isn't created ahead of time either, it's still created
a while after QEMU process start to run.  It's just that I believe CPR
needs to synchronously wait for the client to connect first and send data,
before it can reach other part of QEMU logic to further create the main
channel.

It should look like this:

qemu_init
  cpr_state_load
    cpr_transfer_input
      qio_net_listener_wait_client [1]
  qmp_x_exit_preconfig
    qmp_migrate_incoming [2]
  os_setup_post
    change_process_uid [3]

So IIUC you're looking for [2] creating the other unix socket.

Maybe you can stick with -incoming defer, then it'll be after step [3],
which will inherit the modified uid, and mgmt doesn't need to bother
monitoring.

Thanks,

-- 
Peter Xu


