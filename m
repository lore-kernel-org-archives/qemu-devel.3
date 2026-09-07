Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC4CC79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Y3V-0000zn-J9; Mon, 07 Sep 2026 08:02:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3Y3U-0000zR-Nq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3Y3R-0005Xo-JN
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788782548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F9HMyxED46XCN6471HJElTjW1qiamvjCrxcA4YYomyg=;
 b=Zu3aHDQWkW2D/hno2vdXetsiCBnXArUOH+7M1Y5nja+ks+bgVay9abIujTiH+CsC+63Ngk
 ATrQbRuFGgUndQrJ937ZaicKNCtxeJGmv6KUiwXub6n2+sSOjqoMJE9fxwbp9wmYnlY7D+
 HqrWLfO6ekMYArWIsASFxKZnqi/RQFM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-tenHMa5XMOm65qgujG1wrA-1; Mon, 07 Sep 2026 08:02:26 -0400
X-MC-Unique: tenHMa5XMOm65qgujG1wrA-1
X-Mimecast-MFC-AGG-ID: tenHMa5XMOm65qgujG1wrA_1788782545
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-495529a93f9so34119905e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788782545; x=1789387345; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F9HMyxED46XCN6471HJElTjW1qiamvjCrxcA4YYomyg=;
 b=SjkcHpLbwYOnpgxDQZ2T1gTTtGxXCWoGREopWo1z7moHzIsLXadiGJBf4AL7n+RjtA
 PZaAK0yOa+UaFTxM++MYtzlJgtnke1tHft5KKWccflI0IdgX4CCZcxIQIE/dKa9YJ5F5
 wvjs2lbW6ZOQNpIKoYPMDMLMXvxcnCu49tQPmjZy67EvqJkmXP+ooOpfNGStLZAQP/Z7
 q4tsE+Xi1+zPGRUHY3XxKF7T5YktG343F1Q61DQ64qshlE5MjLp/R5scKRLSdTHvO8NU
 0FJgV79OVNtCIcPvQTeJWrs2ZUc+9afGg5crBR90Pm47V8+b6JE3CKO/QQ9jFVjUVWka
 ck+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788782545; x=1789387345;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F9HMyxED46XCN6471HJElTjW1qiamvjCrxcA4YYomyg=;
 b=VoQm41JIVWRLIMaD+UZH68HFf/beJQ1ccospYsK+nBTzIkcN+FIpK5YVZ8s6+ipz6U
 2sgOGXayMh8wZVBmsoU/KIKMrLumC/N73L0PS1zGDAMH5d1RqKkD4B9oYp8Y+pJ03AMh
 8cZkOiL4ypq7ImWoTvZxkBCLSVfuJAOmsuMXtfC3mV9luksj+4UQb6qlbWM9rIOGu69W
 YAQ8B6lglmD+j593TqUNhD5SiI+ALBJzOHlNAK9aD+fa4wwfYmuh9T7vSQoqwgVVrkSa
 WZpSuYv3V/x3Gq/f1zXomEq7siqfW+89qioWARAmbiXHD6ct6pvSZ1s4gkeJQLcYEGzo
 7n0Q==
X-Gm-Message-State: AFuF++mL7hN3xtb2/NYZA03kORpTJ5j8lYV4cbDoVSZ7gaEzns/EtbIB
 +hHyxyJtBk8QNp60NoDNhrcWNBfk8LMCJhTeE/X4hsNBPRcN9cVmw7ogbKbLOiqF/3bSTkBXlr7
 GqhvHw4aO4O1ANtlfPC+5/T2RYQoRrLiMhx7yg3YBHGJMGDVfcQnihMCV
X-Gm-Gg: AYBFou39JKItqAu8wxAPHYKitNIXn/yXO8UH+oHEmErBF9Ee6OxCq+qHNwr8txkpLNK
 Rg5k/tDQLiGQFm/SIERG3M7nrNGLFYs/OEZjlm8eY7ji1wNEFvjH5An2W7MLsBrWbdxQkdhXb3E
 p0MSL2L0KVS/CEO4t7bvdN6TOxychU/lERd/ZlVOAY/2m+KeEkC4o3/wfVD7npOnZrt4daOeOfF
 8gaKzxVP1LoXtCNY1YjSmurSYvBGai+YgwlqSumidB6NlkoZDcUqARQXdk12gyZwyvBfUxFvbDY
 Ht81uDagF7ptHT4YP7gMfQXd4CnyeQEq6m3w0tIRFjQVPNxiD0y00kcY8K0i7YnULHgo6fVuTIl
 hWFHI9PTs6w992heIFP2Ri5k=
X-Received: by 2002:a05:600c:190b:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49cfa20cd63mr203609185e9.20.1788782545069; 
 Mon, 07 Sep 2026 05:02:25 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49cfa20cd63mr203608345e9.20.1788782544425; 
 Mon, 07 Sep 2026 05:02:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm16658484f8f.37.2026.09.07.05.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:02:23 -0700 (PDT)
Date: Mon, 7 Sep 2026 08:02:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
Message-ID: <20260907075640-mutt-send-email-mst@kernel.org>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

does not look like this patch skips any tests?

On Sun, Sep 06, 2026 at 12:53:34PM +0400, Marc-André Lureau wrote:
> Running vhost-user-bridge built with ASAN with stdbuf dies:
> ==2431898==ASan runtime does not come first in initial library list; you
> should either link runtime to your application or manually preload it
> with LD_PRELOAD.

so it dies but why? judging by below because of stdbuf?

pls describe the fix not just the problem.

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/functional/x86_64/test_vhost_user_bridge.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py b/tests/functional/x86_64/test_vhost_user_bridge.py
> index c36c62542053..5fedf61c5e72 100755
> --- a/tests/functional/x86_64/test_vhost_user_bridge.py
> +++ b/tests/functional/x86_64/test_vhost_user_bridge.py
> @@ -73,12 +73,25 @@ def configure_vm(self, ud_socket_path, lport, rport, hostfwd_port, tftpdir):
>              "-netdev",   "hubport,id=hub1,hubid=0,netdev=user0"
>          )
>  
> +    @staticmethod
> +    def _is_asan_linked(binary_path):
> +        try:
> +            output = subprocess.check_output(
> +                ["ldd", binary_path], stderr=subprocess.DEVNULL, text=True)
> +            return "libasan" in output


this is quite a hack

> +        except (subprocess.CalledProcessError, FileNotFoundError):
> +            return False
> +
>      def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
>          vubr_args = []
>  
>          if (stdbuf_path := which("stdbuf")) is None:
>              self.log.info("Could not find stdbuf: vhost-user-bridge "
>                            "log lines may appear out of order")
> +        elif self._is_asan_linked(vubr_path):
> +            self.log.info("vhost-user-bridge is ASan-linked: skipping "
> +                          "stdbuf to avoid LD_PRELOAD conflict, "
> +                          "log lines may appear out of order")
>          else:
>              vubr_args += [stdbuf_path, "-o0", "-e0"]
>  


maybe just avoid stdbuf completely.
i don't remember why we use it, but it looks like merely to
disable buffering for stdout?

If so:

setvbuf(stdout, NULL, _IONBF, 0);

will do just that with no asan issues.


> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
> 


