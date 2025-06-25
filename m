Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA39C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 16:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSYx-0001X9-2e; Wed, 25 Jun 2025 12:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSYu-0001Wo-35
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 12:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSYr-0008BT-Dn
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750867277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9dzE7jmdNkzmIkmWPx4h+Gjz8vilEHxgx1Y1mH3vbRU=;
 b=FU8c9RM2znJn0nWfqdKXPoER3cXR8gz3gF+JyEcGekdyAH0SYuH9LND4W2LOlaOqJymrvi
 MS1/eFlTeDBukOB1zIHR85wSaNMAelz9T4/yqy1YYkaq1VaT7+intDyMhIuDfPtYfQ194h
 bb9lD2hg2RNS1OJ6SsHy+2A1JtP+fqE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-sNOo6DYhNBCVlXrHHdA6tQ-1; Wed, 25 Jun 2025 12:01:14 -0400
X-MC-Unique: sNOo6DYhNBCVlXrHHdA6tQ-1
X-Mimecast-MFC-AGG-ID: sNOo6DYhNBCVlXrHHdA6tQ_1750867273
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4e9252ba0so3654546f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 09:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750867273; x=1751472073;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9dzE7jmdNkzmIkmWPx4h+Gjz8vilEHxgx1Y1mH3vbRU=;
 b=OG1b9XlyerpVLIwjBZ7XJ519c7w69LC6No9z2ZtJIzTgLMfkHoBAWuQCbs7clMJhIY
 hAZbUFC+Z6nuWvF3Ou40YMAFOlWx2g/AeabboSgkUI5OyIxiGd6uef7OdIw2uzEYZJwu
 J/yqmwBBQO7iRZL2tt4QHyS8OzrImMfz/dRurQu/+H832v5Doxpxab65Wsi0YaZ0n8V0
 U080xFYGSt4us5IzaO4m2B1yhXZkCOUbRS4XwHaebs9Fw8iL/kqMUjaA3k6C+64rrUmZ
 bnTaSYZRrepFeh+eMwVgto5Ss82hldPWQVCGLRxePz7TGkUhxiIAqAxlxrDJQ9pceL3t
 PYVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVksEJda7GEQ0+BFGwPJtJEVZSyWfIykbeiP7ExqvpnUa4+yAMlxAdBf7ld4xF+9Fl2ntPloRGrPeqC@nongnu.org
X-Gm-Message-State: AOJu0Yx8n7SybJbhyx1spqrFJcDUac60vzC48zgZgvD+L4z+h2x3DbsB
 3JiIHs72SzuMhQXswDObwGtploGpM9GI6EIV0Hn93CPP4U8t1Al+Ea8jtWsXInXmv+Qs6G8lDsM
 VA2PbPYbFE4sXT1fbIPS5yHJlJIzI3c8yFtAdKztyWEE11cJV0/6Wvisp
X-Gm-Gg: ASbGncsoziSIr3N7IEiwb+hYkngG0/C5vNdbWOopsP/2p5+cT142C4vkgyPZzpCwXIL
 rYMk88+t/6VwliQwFS3p1Fa6sAegUIr3E3QbiGdjhF8qhHXZyD/bwDRmsU57hoQOykrrA09Xj4c
 JdnGDx/xBhjEVksm4V0foZQ//JPyeoLL8417n2y1hl23vX600nZ37Ja/kqaDYCKCNNAEAa+tzI4
 H89Im4N/dqll9R46fFKj5nz6ZTWMGyNicvL8K+25HW5re4QDN/eY68Eimtyz7DJFsxB9Ge//j6N
 0K76aPv+cP3CLEBR9A6eOOjuTHlcDC69SKjV9KlpQJPM2f4HJjkxLdC4izzJenc=
X-Received: by 2002:a05:6000:2210:b0:3a4:c713:7d8 with SMTP id
 ffacd0b85a97d-3a6ed5da5b0mr3138378f8f.16.1750867272200; 
 Wed, 25 Jun 2025 09:01:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXd7yK9PmjtRLtQaX4nmFcd7fCC+ggZBFPupmX7rCLVageq0fkio9MVx2+goHdYjbxBPQP4A==
X-Received: by 2002:a05:6000:2210:b0:3a4:c713:7d8 with SMTP id
 ffacd0b85a97d-3a6ed5da5b0mr3138155f8f.16.1750867270025; 
 Wed, 25 Jun 2025 09:01:10 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8055f0asm5031850f8f.4.2025.06.25.09.01.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 09:01:07 -0700 (PDT)
Message-ID: <8353807e-b9d1-4de9-be30-76d107129fb6@redhat.com>
Date: Wed, 25 Jun 2025 18:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] util/rcu.c: replace FSF postal address with
 licenses URL
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.07@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250613.qemu.patch.07@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/06/2025 18.46, Sean Wei wrote:
> The LGPLv2.1 boiler-plate in util/rcu.c still contained
> the obsolete "51 Franklin Street" postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   util/rcu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/util/rcu.c b/util/rcu.c
> index fa32c942e4..b703c86f15 100644
> --- a/util/rcu.c
> +++ b/util/rcu.c
> @@ -20,8 +20,8 @@
>    * Lesser General Public License for more details.
>    *
>    * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * License along with this library; if not, see
> + * <https://www.gnu.org/licenses/>.
>    *
>    * IBM's contributions to this file may be relicensed under LGPLv2 or later.
>    */

Reviewed-by: Thomas Huth <thuth@redhat.com>


